%% Make predictions with boosted trees

tic

%load('forxgb.mat', 'new_submit_feats');
%load('forxgb_model.mat', 'MdlFinal_xgb');
%load('forxgb.mat', 'boxcox_lambdas');

%predictions = predict(MdlFinal_xgb, new_submit_feats);

% Create csv file to submit
id = new_submit_feats(:, 1);
lambda = boxcox_lambdas(15, 1);
loss = ((predictions .* lambda) + 1) .^ (1 / lambda);
submit_table_reg = table(id, loss);
writetable(submit_table_reg, 'submit_matlab_forxgb.csv');

toc      % 