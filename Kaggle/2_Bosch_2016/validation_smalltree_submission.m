tic

id=[];
prediction=[];

%1_5
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_1_5'); %ch
for i = 1:5
  varname=strjoin({'cluster',num2str(i)},'');
  varname  %cluster1... cluster5
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i));
  X=submit_clusters_for_class_1_5{i,1}(:,2:end-1); %ch
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_1_5{i,1}(:,1)];  %ch
  prediction=[prediction;Yfit];
end;

clearvars cluster1 cluster2 cluster3 cluster4 cluster5;
clearvars submit_clusters_for_class_1_5;

%6_10
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_6_10'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+5)},'');  %ch  i+5
  varname  %cluster6... cluster10                %ch
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+5));          %ch i+5
  X=submit_clusters_for_class_6_10{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_6_10{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;


clearvars cluster6 cluster7 cluster8 cluster9 cluster10;
clearvars submit_clusters_for_class_6_10;

%11_15
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_11_15'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+10)},'');  %ch  i+5
  varname  %cluster11... cluster15                %ch
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+10));          %ch i+5
  X=submit_clusters_for_class_11_15{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_11_15{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;


clearvars cluster11 cluster12 cluster13 cluster14 cluster15;
clearvars submit_clusters_for_class_11_15;

%16_20
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_16_20'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+15)},'');  %ch  i+5
  varname                 
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+15));          %ch i+5
  X=submit_clusters_for_class_16_20{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_16_20{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;


clearvars cluster16 cluster17 cluster18 cluster19 cluster20;
clearvars submit_clusters_for_class_16_20;

%21_25
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_21_25'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+20)},'');  %ch  i+5
  varname                 
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+20));          %ch i+5
  X=submit_clusters_for_class_21_25{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_21_25{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;


clearvars cluster21 cluster22 cluster23 cluster24 cluster25;
clearvars submit_clusters_for_class_21_25;

%26_30
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_26_30'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+25)},'');  %ch  i+5
  varname                 
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+25));          %ch i+5
  X=submit_clusters_for_class_26_30{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_26_30{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;


clearvars cluster26 cluster27 cluster28 cluster29 cluster30;
clearvars submit_clusters_for_class_26_30;

%31_35
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_31_35'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+30)},'');  %ch  i+5
  varname                 
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+30));          %ch i+5
  X=submit_clusters_for_class_31_35{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_31_35{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;


clearvars cluster31 cluster32 cluster33 cluster34 cluster35;
clearvars submit_clusters_for_class_31_35;

%36_40
load('submit_final_data_for_class.mat', 'submit_clusters_for_class_36_40'); %ch 6_10
for i = 1:5
  varname=strjoin({'cluster',num2str(i+35)},'');  %ch  i+5
  varname                 
  load('adaboost_smalltree_clusters5.mat', varname);
  eval(sprintf('cluster=cluster%d', i+35));          %ch i+5
  X=submit_clusters_for_class_36_40{i,1}(:,2:end-1); %ch 6_10
  Yfit = predict(cluster,X);
  id=[id;submit_clusters_for_class_36_40{i,1}(:,1)];  %ch 6_10
  prediction=[prediction;Yfit];
end;

clearvars cluster1 cluster2 cluster3 cluster4 cluster5;
clearvars submit_clusters_for_class_36_40;

T = table(id,prediction);
writetable(T,'submission_adaboost_161111.csv','Delimiter',',')

toc            % Elapsed time is 2812.318471 seconds.