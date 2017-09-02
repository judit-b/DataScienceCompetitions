%% One-hot encoding the dataset for submit

tic

load('for_submit.mat', 'forsubmit_matrix');
load('dataset.mat', 'firstColToEncode');
load('dataset.mat', 'lastColToEncode');
load('dataset.mat', 'catToNumber');

% calculate the number of columns of one-hot encoding
numOneHot = 0;
for i = firstColToEncode : lastColToEncode
    numOneHot = numOneHot + height(catToNumber{i, 1});
end;

numRemainingCols = 131 - (lastColToEncode - firstColToEncode + 1);
forsubmit_onehot = zeros(size(forsubmit_matrix, 1), numRemainingCols + numOneHot);
forsubmit_onehot(:, 1 : firstColToEncode - 1) = forsubmit_matrix(:, 1 : firstColToEncode - 1);
forsubmit_onehot(:, firstColToEncode + numOneHot : end) = forsubmit_matrix(:, lastColToEncode + 1 : end);

nextColToEncode = firstColToEncode;
for i = firstColToEncode : lastColToEncode
    i
    numCats = height(catToNumber{i, 1});
    one_hot = ind2vec(forsubmit_matrix(:, i)', numCats)';
    forsubmit_onehot(:, nextColToEncode : nextColToEncode + numCats - 1) = one_hot;
    nextColToEncode = nextColToEncode + numCats;
end;

save('for_submit.mat', 'forsubmit_onehot', '-append');

toc          % Elapsed time is 8.236971 seconds.
