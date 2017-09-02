tic

load('final_valid_set_for_class.mat', 'valid_clusters_for_class');

pred=cell(40,2);
tp=0;
tn=0;
fp=0;
fn=0;
id=[];
prediction=[];

for i = 1:40
    
  
  varname=strjoin({'cluster',num2str(i)},'');
  varname
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i));
  X=valid_clusters_for_class{i,1}(:,2:end-1);
  Y=valid_clusters_for_class{i,1}(:,end);
  
  Yfit = predict(cluster,X);
  [ TP, TN, FP, FN ] = evaluate( Y, Yfit);
  tp=tp+TP;
  tn=tn+TN;
  fp=fp+FP;
  fn=fn+FN;
  
  pred{i,1}=valid_clusters_for_class{i,1}(:,1);
  pred{i,2}=Yfit;
  id=[id;valid_clusters_for_class{i,1}(:,1)];
  prediction=[prediction;Yfit];
  
  
  
end;
%T = table(id,prediction);
%writetable(T,'prediction.csv','Delimiter',',')
%save('prediction_adaboost.mat', 'pred'); %change name!


mcc( tp, tn, fp, fn )

toc           % Elapsed time is 830.008517 seconds.