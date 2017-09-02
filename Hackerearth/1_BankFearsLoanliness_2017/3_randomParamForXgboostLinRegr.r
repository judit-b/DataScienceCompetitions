library(data.table)
library(Matrix)
library(xgboost)
library(Metrics)

set.seed(0)

ID = 'member_id'
TARGET = 'loan_status'
TRAIN_FILE = "C:/Users/Public/Hackerearth/1_MachineLearningChallenge_2017march/train_onehot.csv"
train = fread(TRAIN_FILE, showProgress = TRUE)
y_train = train[,TARGET, with = FALSE][[TARGET]]
train[, c(ID, TARGET) := NULL]
x_train = train
dtrain = xgb.DMatrix(as.matrix(x_train), label=y_train)


best_param = list()
best_seednumber = 1234
best_auc = 0
best_auc_index = 0

values_1 = c(0.6, 0.8, 1)
values_2 = c(4, 6, 8, 10)
values_3 = c(0, 0.3, 0.6, 0.9)
values_4 = c(5, 10, 15, 20, 25, 30, 35, 40)


for (iter in 1:100) {
    print(iter)
    param <- list(objective = 'reg:linear',
          eval_metric = "auc",
          max_depth = sample(values_2, size = 1),
          eta = 1,     #runif(1, .01, .3),
          gamma = sample(values_3, size = 1), 
          subsample = sample(values_1, size = 1),
          colsample_bytree = sample(values_1, size = 1), 
          min_child_weight = sample(values_4, size = 1)
          )
    cv.nround = 300
    cv.nfold = 5
    seed.number = sample.int(10000, 1)[[1]]
    set.seed(seed.number)
    mdcv <- xgb.cv(data=dtrain, params = param, nthread=7, 
                    nfold=cv.nfold, nrounds=cv.nround, early.stop.round = 50,
                    verbose = F)

    max_auc = max(mdcv[, test.auc.mean])
    max_auc_index = which.max(mdcv[, test.auc.mean])

    if (max_auc > best_auc) {
        best_auc = max_auc
        best_auc_index = max_auc_index
        best_seednumber = seed.number
        best_param = param
    }
    print('')
    print(best_auc)
    print(best_auc_index)
    print('')
}

