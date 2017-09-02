library(data.table)
library(Matrix)
library(xgboost)
library(Metrics)

set.seed(0)
ID = 'id'
TARGET = 'loss'
SEED = 0
SHIFT = 200
TRAIN_FILE = "G:/Judit/Kaggle/2_Allstate_2016/dataset/train.csv"
TEST_FILE = "G:/Judit/Kaggle/2_Allstate_2016/dataset/test.csv"
SUBMISSION_FILE = "G:/Judit/Kaggle/2_Allstate_2016/dataset/sample_submission.csv"
train = fread(TRAIN_FILE, showProgress = TRUE)
test = fread(TEST_FILE, showProgress = TRUE)
y_train = log(train[,TARGET, with = FALSE] + SHIFT)[[TARGET]]
train[, c(ID, TARGET) := NULL]
test[, c(ID) := NULL]
ntrain = nrow(train)
train_test = rbind(train, test)
features = names(train)
for (f in features) {
  if (class(train_test[[f]])=="character") {
    #cat("VARIABLE : ",f,"\n")
    levels <- sort(unique(train_test[[f]]))
    train_test[[f]] <- as.integer(factor(train_test[[f]], levels=levels))
  }
}
x_train = train_test[1:ntrain,]
x_test = train_test[(ntrain+1):nrow(train_test),]
dtrain = xgb.DMatrix(as.matrix(x_train), label=y_train)
dtest = xgb.DMatrix(as.matrix(x_test))

xg_eval_mae <- function (yhat, dtrain) {
  y = getinfo(dtrain, "label")
  err= mae(exp(y),exp(yhat) )
  return (list(metric = "error", value = err))
}

logcoshobj <- function(preds, dtrain) {
  labels <- getinfo(dtrain, "label")
  grad <- tanh(preds-labels)
  hess <- 1-grad*grad
  return(list(grad = grad, hess = hess))
}

cauchyobj <- function(preds, dtrain) {
  labels <- getinfo(dtrain, "label")
  c <- 3  #the lower the "slower/smoother" the loss is. Cross-Validate.
  x <-  preds-labels
  grad <- x / (x^2/c^2+1)
  hess <- -c^2*(x^2-c^2)/(x^2+c^2)^2
  return(list(grad = grad, hess = hess))
}


fairobj <- function(preds, dtrain) {
  labels <- getinfo(dtrain, "label")
  c <- 2 #the lower the "slower/smoother" the loss is. Cross-Validate.
  x <-  preds-labels
  grad <- c*x / (abs(x)+c)
  hess <- c^2 / (abs(x)+c)^2
  return(list(grad = grad, hess = hess))
}

xgb_params = list(
  colsample_bytree = 0.5,
  subsample = 0.8,
  eta = 0.01,
  objective = logcoshobj, #fairobj #logcoshobj, #cauchyobj #,#'reg:linear',
  eval_metric = xg_eval_mae, # "mae"
  max_depth = 12,
  alpha = 1,
  gamma = 2,
  min_child_weight = 1,
  base_score = 7.76
)

res = xgb.cv(xgb_params,
             dtrain,
             nrounds=5000,
             nfold=5,
             early_stopping_rounds=15,
             print_every_n = 10,
             verbose= 2,
             #obj = cauchyobj,  #fairobj, #logcoshobj, #cauchyobj #
             #feval = xg_eval_mae, #"mae" 
             maximize=FALSE)
best_nrounds = which.min(res$evaluation_log$test_error_mean)
cv_mean = res$evaluation_log$test_error_mean[best_nrounds]
cv_std = res$evaluation_log$test_error_std[best_nrounds]
cat(paste0('CV-Mean: ',cv_mean,' ', cv_std))
#best_nrounds=4577
#CV-Mean: 1132.47391638384 7.70838248417187

gbdt = xgb.train(xgb_params, dtrain, nrounds = as.integer(best_nrounds),verbose= 2 )
submission = fread(SUBMISSION_FILE, colClasses = c("integer", "numeric"))
submission$loss = exp(predict(gbdt,dtest)) - SHIFT
write.csv(submission,'G:/Judit/Kaggle/2_Allstate_2016/submissions/submission_xgb.csv',row.names = FALSE)
# Public score: 1114.06178, private score: 1125.77973