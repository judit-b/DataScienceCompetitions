%% Third method - 3

tic

load('third_dataset_nanrepr.mat', 'valid_nanrepr_1');
disp(1);
% Want to know, for each pairs of rows from the validation set and training
% set, the number of features where there is either a value or NaN in both
% place. The element of the following matrix in the ith row and jth column
% is equal to the following: take the ith row of the training set and the
% jth row of the validation set and count the number of places where there
% is value or NaN in both rows and where there is a value in one of them
% and NaN in the other. Then calculate (number of places with value or NaN
% in both rows) minus (number of places with value in one of them and NaN
% in the other).
% best_trains_for_valid_1 stores the most similar rows in the training set
% for each row in valid_nanrepr_1.
% best_trains_for_valid_1{i, 1} is the similarity of the ith element in the 
% validation set to the closest row in train_nanrepr_1 ... train_nanrepr_6
% best_trains_for_valid_1{i, 2} stores all the IDs for the most similar train
% rows
best_trains_for_valid_1 = cell(size(valid_nanrepr_1, 1), 2); 
load('third_dataset_nanrepr.mat', 'train_nanrepr_1');
train = train_nanrepr_1;
clearvars train_nanrepr_1;
for i = 1 : size(valid_nanrepr_1(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid_nanrepr_1(i, 2:end-1)));
        if j == 1
            best_trains_for_valid_1{i, 1} = similarity;
            best_trains_for_valid_1{i, 2} = train(j, 1);
        elseif similarity > best_trains_for_valid_1{i, 1}
            best_trains_for_valid_1{i, 1} = similarity;
            best_trains_for_valid_1{i, 2} = train(j, 1);
        elseif similarity == best_trains_for_valid_1{i, 1}
            best_trains_for_valid_1{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'train_nanrepr_2');
best_trains_for_valid_1 = FindMostSimilarTrainNanRepr(valid_nanrepr_1,...
    train_nanrepr_2, best_trains_for_valid_1);
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'train_nanrepr_3');
best_trains_for_valid_1 = FindMostSimilarTrainNanRepr(valid_nanrepr_1,...
    train_nanrepr_3, best_trains_for_valid_1);
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'train_nanrepr_4');
best_trains_for_valid_1 = FindMostSimilarTrainNanRepr(valid_nanrepr_1,...
    train_nanrepr_4, best_trains_for_valid_1);
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'train_nanrepr_5');
best_trains_for_valid_1 = FindMostSimilarTrainNanRepr(valid_nanrepr_1,...
    train_nanrepr_5, best_trains_for_valid_1);
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'train_nanrepr_6');
best_trains_for_valid_1 = FindMostSimilarTrainNanRepr(valid_nanrepr_1,...
    train_nanrepr_6, best_trains_for_valid_1);
clearvars train_nanrepr_6;

save('third_most_similars_to_valid.mat', 'best_trains_for_valid_1');
clearvars best_trains_for_valid_1 valid_nanrepr_1;


load('third_dataset_nanrepr.mat', 'valid_nanrepr_2');
disp(2);
best_trains_for_valid_2 = cell(size(valid_nanrepr_2, 1), 2); 
load('third_dataset_nanrepr.mat', 'train_nanrepr_1');
train = train_nanrepr_1;
clearvars train_nanrepr_1;
for i = 1 : size(valid_nanrepr_2(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid_nanrepr_2(i, 2:end-1)));
        if j == 1
            best_trains_for_valid_2{i, 1} = similarity;
            best_trains_for_valid_2{i, 2} = train(j, 1);
        elseif similarity > best_trains_for_valid_2{i, 1}
            best_trains_for_valid_2{i, 1} = similarity;
            best_trains_for_valid_2{i, 2} = train(j, 1);
        elseif similarity == best_trains_for_valid_2{i, 1}
            best_trains_for_valid_2{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'train_nanrepr_2');
best_trains_for_valid_2 = FindMostSimilarTrainNanRepr(valid_nanrepr_2,...
    train_nanrepr_2, best_trains_for_valid_2);
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'train_nanrepr_3');
best_trains_for_valid_2 = FindMostSimilarTrainNanRepr(valid_nanrepr_2,...
    train_nanrepr_3, best_trains_for_valid_2);
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'train_nanrepr_4');
best_trains_for_valid_2 = FindMostSimilarTrainNanRepr(valid_nanrepr_2,...
    train_nanrepr_4, best_trains_for_valid_2);
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'train_nanrepr_5');
best_trains_for_valid_2 = FindMostSimilarTrainNanRepr(valid_nanrepr_2,...
    train_nanrepr_5, best_trains_for_valid_2);
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'train_nanrepr_6');
best_trains_for_valid_2 = FindMostSimilarTrainNanRepr(valid_nanrepr_2,...
    train_nanrepr_6, best_trains_for_valid_2);
clearvars train_nanrepr_6;

save('third_most_similars_to_valid.mat', 'best_trains_for_valid_2', '-append');
clearvars best_trains_for_valid_2 valid_nanrepr_2;


load('third_dataset_nanrepr.mat', 'valid_nanrepr_3');
disp(3);
best_trains_for_valid_3 = cell(size(valid_nanrepr_3, 1), 2); 
load('third_dataset_nanrepr.mat', 'train_nanrepr_1');
train = train_nanrepr_1;
clearvars train_nanrepr_1;
for i = 1 : size(valid_nanrepr_3(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid_nanrepr_3(i, 2:end-1)));
        if j == 1
            best_trains_for_valid_3{i, 1} = similarity;
            best_trains_for_valid_3{i, 2} = train(j, 1);
        elseif similarity > best_trains_for_valid_3{i, 1}
            best_trains_for_valid_3{i, 1} = similarity;
            best_trains_for_valid_3{i, 2} = train(j, 1);
        elseif similarity == best_trains_for_valid_3{i, 1}
            best_trains_for_valid_3{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'train_nanrepr_2');
best_trains_for_valid_3 = FindMostSimilarTrainNanRepr(valid_nanrepr_3,...
    train_nanrepr_2, best_trains_for_valid_3);
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'train_nanrepr_3');
best_trains_for_valid_3 = FindMostSimilarTrainNanRepr(valid_nanrepr_3,...
    train_nanrepr_3, best_trains_for_valid_3);
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'train_nanrepr_4');
best_trains_for_valid_3 = FindMostSimilarTrainNanRepr(valid_nanrepr_3,...
    train_nanrepr_4, best_trains_for_valid_3);
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'train_nanrepr_5');
best_trains_for_valid_3 = FindMostSimilarTrainNanRepr(valid_nanrepr_3,...
    train_nanrepr_5, best_trains_for_valid_3);
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'train_nanrepr_6');
best_trains_for_valid_3 = FindMostSimilarTrainNanRepr(valid_nanrepr_3,...
    train_nanrepr_6, best_trains_for_valid_3);
clearvars train_nanrepr_6;

save('third_most_similars_to_valid.mat', 'best_trains_for_valid_3', '-append');
clearvars best_trains_for_valid_3 valid_nanrepr_3;


load('third_dataset_nanrepr.mat', 'valid_nanrepr_4');
disp(4);
best_trains_for_valid_4 = cell(size(valid_nanrepr_4, 1), 2); 
load('third_dataset_nanrepr.mat', 'train_nanrepr_1');
train = train_nanrepr_1;
clearvars train_nanrepr_1;
for i = 1 : size(valid_nanrepr_4(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid_nanrepr_4(i, 2:end-1)));
        if j == 1
            best_trains_for_valid_4{i, 1} = similarity;
            best_trains_for_valid_4{i, 2} = train(j, 1);
        elseif similarity > best_trains_for_valid_4{i, 1}
            best_trains_for_valid_4{i, 1} = similarity;
            best_trains_for_valid_4{i, 2} = train(j, 1);
        elseif similarity == best_trains_for_valid_4{i, 1}
            best_trains_for_valid_4{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'train_nanrepr_2');
best_trains_for_valid_4 = FindMostSimilarTrainNanRepr(valid_nanrepr_4,...
    train_nanrepr_2, best_trains_for_valid_4);
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'train_nanrepr_3');
best_trains_for_valid_4 = FindMostSimilarTrainNanRepr(valid_nanrepr_4,...
    train_nanrepr_3, best_trains_for_valid_4);
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'train_nanrepr_4');
best_trains_for_valid_4 = FindMostSimilarTrainNanRepr(valid_nanrepr_4,...
    train_nanrepr_4, best_trains_for_valid_4);
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'train_nanrepr_5');
best_trains_for_valid_4 = FindMostSimilarTrainNanRepr(valid_nanrepr_4,...
    train_nanrepr_5, best_trains_for_valid_4);
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'train_nanrepr_6');
best_trains_for_valid_4 = FindMostSimilarTrainNanRepr(valid_nanrepr_4,...
    train_nanrepr_6, best_trains_for_valid_4);
clearvars train_nanrepr_6;

save('third_most_similars_to_valid.mat', 'best_trains_for_valid_4', '-append');
clearvars best_trains_for_valid_4 valid_nanrepr_4;


load('third_dataset_nanrepr.mat', 'valid_nanrepr_5');
disp(5);
best_trains_for_valid_5 = cell(size(valid_nanrepr_5, 1), 2); 
load('third_dataset_nanrepr.mat', 'train_nanrepr_1');
train = train_nanrepr_1;
clearvars train_nanrepr_1;
for i = 1 : size(valid_nanrepr_5(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid_nanrepr_5(i, 2:end-1)));
        if j == 1
            best_trains_for_valid_5{i, 1} = similarity;
            best_trains_for_valid_5{i, 2} = train(j, 1);
        elseif similarity > best_trains_for_valid_5{i, 1}
            best_trains_for_valid_5{i, 1} = similarity;
            best_trains_for_valid_5{i, 2} = train(j, 1);
        elseif similarity == best_trains_for_valid_5{i, 1}
            best_trains_for_valid_5{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'train_nanrepr_2');
best_trains_for_valid_5 = FindMostSimilarTrainNanRepr(valid_nanrepr_5,...
    train_nanrepr_2, best_trains_for_valid_5);
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'train_nanrepr_3');
best_trains_for_valid_5 = FindMostSimilarTrainNanRepr(valid_nanrepr_5,...
    train_nanrepr_3, best_trains_for_valid_5);
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'train_nanrepr_4');
best_trains_for_valid_5 = FindMostSimilarTrainNanRepr(valid_nanrepr_5,...
    train_nanrepr_4, best_trains_for_valid_5);
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'train_nanrepr_5');
best_trains_for_valid_5 = FindMostSimilarTrainNanRepr(valid_nanrepr_5,...
    train_nanrepr_5, best_trains_for_valid_5);
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'train_nanrepr_6');
best_trains_for_valid_5 = FindMostSimilarTrainNanRepr(valid_nanrepr_5,...
    train_nanrepr_6, best_trains_for_valid_5);
clearvars train_nanrepr_6;

save('third_most_similars_to_valid.mat', 'best_trains_for_valid_5', '-append');
clearvars best_trains_for_valid_5 valid_nanrepr_5;


load('third_dataset_nanrepr.mat', 'valid_nanrepr_6');
disp(6);
best_trains_for_valid_6 = cell(size(valid_nanrepr_6, 1), 2); 
load('third_dataset_nanrepr.mat', 'train_nanrepr_1');
train = train_nanrepr_1;
clearvars train_nanrepr_1;
for i = 1 : size(valid_nanrepr_6(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid_nanrepr_6(i, 2:end-1)));
        if j == 1
            best_trains_for_valid_6{i, 1} = similarity;
            best_trains_for_valid_6{i, 2} = train(j, 1);
        elseif similarity > best_trains_for_valid_6{i, 1}
            best_trains_for_valid_6{i, 1} = similarity;
            best_trains_for_valid_6{i, 2} = train(j, 1);
        elseif similarity == best_trains_for_valid_6{i, 1}
            best_trains_for_valid_6{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;
clearvars train_nanrepr_1;

load('third_dataset_nanrepr.mat', 'train_nanrepr_2');
best_trains_for_valid_6 = FindMostSimilarTrainNanRepr(valid_nanrepr_6,...
    train_nanrepr_2, best_trains_for_valid_6);
clearvars train_nanrepr_2;

load('third_dataset_nanrepr.mat', 'train_nanrepr_3');
best_trains_for_valid_6 = FindMostSimilarTrainNanRepr(valid_nanrepr_6,...
    train_nanrepr_3, best_trains_for_valid_6);
clearvars train_nanrepr_3;

load('third_dataset_nanrepr.mat', 'train_nanrepr_4');
best_trains_for_valid_6 = FindMostSimilarTrainNanRepr(valid_nanrepr_6,...
    train_nanrepr_4, best_trains_for_valid_6);
clearvars train_nanrepr_4;

load('third_dataset_nanrepr.mat', 'train_nanrepr_5');
best_trains_for_valid_6 = FindMostSimilarTrainNanRepr(valid_nanrepr_6,...
    train_nanrepr_5, best_trains_for_valid_6);
clearvars train_nanrepr_5;

load('third_dataset_nanrepr.mat', 'train_nanrepr_6');
best_trains_for_valid_6 = FindMostSimilarTrainNanRepr(valid_nanrepr_6,...
    train_nanrepr_6, best_trains_for_valid_6);
clearvars train_nanrepr_6;

save('third_most_similars_to_valid.mat', 'best_trains_for_valid_6', '-append');
clearvars best_trains_for_valid_6 valid_nanrepr_6;

