load('anomaly_sym_clusters_095.mat');    % training set
cellarray1=all_sym_clusters_1;
cellarray2=all_sym_clusters_2;
load('anomaly_final_valid_set_095.mat');        % validation set
valdata=anomaly_final_valid_clusters;
load('anomaly_imputed_test_clusters.mat');        % test set
testdata=anomaly_test_clusters;
Y_fit=[];
Y=[];
sigmadiag=[];
rng(210);
models=cell(100,1);
tresholds=cell(100,1);
for i=1:100
  i
  if i<=50
    x=cellarray1{i,1}(:,2:end-1);
  else
    x=cellarray2{i,1}(:,2:end-1);
  end;

  mccs=[];
  %GMModel = fitgmdist(x,3,'RegularizationValue', 0.01, 'Replicates',2); %instead:
  %%%%%%%%%%%%%%%%%%%%
  AIC = zeros(1,5);
  GMModels = cell(1,5);
  
  for k = 1:5
    GMModels{k} = fitgmdist(x,k,'RegularizationValue', 0.01, 'Replicates',10);
    AIC(k)= GMModels{k}.AIC;
  end;

  [minAIC,numComponents] = min(AIC);
  numComponents

  GMModel = GMModels{numComponents}
  models{i,1}=GMModel;
  %%%%%%%%%%%%%%%%%
  sigma=GMModel.Sigma;
  mu=GMModel.mu;
  ytest=testdata{i,1}(:,end);
  v=valdata{i,1}(:,2:end-1);
  yval=valdata{i,1}(:,end);
  bad=yval==1;
  density=pdf(GMModel,v);
  minimal_prob=min(density(bad));
  maximal_prob=max(density(bad));
  L=floor(log2(maximal_prob/minimal_prob));
  epsilons=2.^linspace(1,L,L);
  n=length(epsilons);  
  mccopt=-1;
  yoptfit=zeros(size(yval,1),1);
  tc=[0 0 0 0];
  e=0;
  for j=1:n
    yfit=(density<epsilons(j));
    [ tp, tn, fp, fn ] = evaluate( yval, yfit);
    mc=mcc( tp, tn, fp, fn );
    if mc>mccopt
      mccopt=mc;
      e=epsilons(j);
    end;
    if mccopt==-1
      e=epsilons(1);
    end;
  end;
  tresholds{i,1}=e;
  densitytest=pdf(GMModel,testdata{i,1}(:,2:end-1)); %new
  yoptfit=(densitytest<e);
  Y_fit=[Y_fit;yoptfit];
  Y=[Y;ytest];
end;
[ TP, TN, FP, FN ] = evaluate( Y, Y_fit);
fprintf('value of mcc: %f\n', mcc( TP, TN, FP, FN ));
fprintf('number of anomalies: %f\n', sum(Y_fit));
fprintf('number of data: %f\n', length(Y));
save('anomaly_models.mat', 'models'); 
save('anomaly_models.mat', 'tresholds', '-append');



