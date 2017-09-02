function [ TP, TN, FP, FN ] = evaluate( Y, Yfit )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
TP=0;
TN=0;
FP=0;
FN=0;
s=Y+Yfit;
d=Y-Yfit;
truePositives=(s==2);
trueNegatives=(s==0);
falsePositives=(d==-1);
falseNegatives=(d==1);
TP=sum(truePositives);
TN=sum(trueNegatives);
FP=sum(falsePositives);
FN=sum(falseNegatives);
end

