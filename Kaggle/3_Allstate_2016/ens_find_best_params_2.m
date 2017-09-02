%% optimize hyperparameters automatically

tic
rng(1)

load('lin_regr.mat', 'sample_feats_01');
load('lin_regr.mat', 'sample_log_target');

Mdl = fitrensemble(sample_feats_01, sample_log_target,'NPrint', 50, 'OptimizeHyperparameters','all',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));

toc        % Elapsed time is 11449.495172 seconds.