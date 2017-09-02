function metric = mcc( TP, TN, FP, FN )
%Computes Matthews correlation coeffitient
%   Detailed explanation goes here
  if (TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)~=0
    metric=(TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
  else
    metric=0;
  end;

end

