library(data.table)
library(Matrix)
library(xgboost)
library(Metrics)

set.seed(10)

ID = 'member_id'
TARGET = 'loan_status'
TRAIN_FILE = "C:/Users/Badics Judit/Hackerearth/1_MachineLearningChallenge_2017march/ESztitol/train_onehot.csv"
train = fread(TRAIN_FILE, showProgress = TRUE)
y_train = train[,TARGET, with = FALSE][[TARGET]]
train[, c(ID, TARGET) := NULL]
x_train = train
dtrain = xgb.DMatrix(as.matrix(x_train), label=y_train)

rm(train)
rm(TRAIN_FILE)
gc()


xgb_params = list(
    max_depth = 8,
    eta = 0.02,
    gamma = 0.1,
    subsample = 1,
    colsample_bytree = 0.8,
    min_child_weight = 35,
    objective = 'reg:linear', 
    eval_metric = "auc"
)

set.seed(1670)

md <- xgb.train(data=dtrain, params=xgb_params, nrounds = 11136, nthread=7)

VALID_FILE = "C:/Users/Badics Judit/Hackerearth/1_MachineLearningChallenge_2017march/ESztitol/valid_onehot.csv"
x_valid = fread(VALID_FILE, showProgress = TRUE)
y_valid = x_valid[,TARGET, with = FALSE][[TARGET]]
x_valid[, c(ID, TARGET) := NULL]
dvalid = xgb.DMatrix(as.matrix(x_valid))
x_valid$pred = predict(md,dvalid)
auc(y_valid, x_valid$pred)

TEST_FILE = "C:/Users/Badics Judit/Hackerearth/1_MachineLearningChallenge_2017march/ESztitol/test_onehot.csv"
x_test = fread(TEST_FILE, showProgress = TRUE)
x_test[, c(ID) := NULL]
dtest = xgb.DMatrix(as.matrix(x_test))
SUBMISSION_FILE = "C:/Users/Badics Judit/Hackerearth/1_MachineLearningChallenge_2017march/ESztitol/submit_170321_8_modified.csv"
submission = fread(SUBMISSION_FILE, colClasses = c("integer", "numeric"))
submission$loan_status = predict(md,dtest)

# Transform loan_status into the [0.1, 0.9] interval
submission$loan_status = submission$loan_status - min(submission$loan_status)
submission$loan_status = submission$loan_status / max(submission$loan_status)
submission$loan_status = 0.8 * submission$loan_status
submission$loan_status = submission$loan_status + 0.1

write.csv(submission,'xgb_regr_with_r_170325_10a.csv',row.names = FALSE)
