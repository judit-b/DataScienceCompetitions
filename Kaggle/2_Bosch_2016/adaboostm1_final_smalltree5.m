load('anomaly_balanced_clusters_knn.mat', 'all_balanced_clusters');
tic
rng(1)
output_small=cell(40,1);
dummy=0;
save('adaboost_smalltree_clusters5.mat', 'dummy');
for i = 1:40
    
  
  
  X=all_balanced_clusters{i,1}(:,2:end-1);
  Y=all_balanced_clusters{i,1}(:,end);
  
  t = templateTree('MaxNumSplits', 4);
  tree = fitensemble(X,Y,'AdaBoostM1','Learners', t,...
    'LearnRate',0.1,'NLearn',2000);
  
  eval(sprintf('cluster%d = tree', i));
  varname=strjoin({'cluster',num2str(i)},'');
  save('adaboost_smalltree_clusters5.mat', varname,'-append');
  clearvars varname;
end;

toc      % Elapsed time is 1762.170394 seconds.

