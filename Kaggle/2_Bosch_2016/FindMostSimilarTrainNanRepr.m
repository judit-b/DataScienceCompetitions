function best_trains_for_valid = FindMostSimilarTrainNanRepr(valid, train, bestsSoFar)

for i = 1 : size(valid(:, 2:end-1), 1)
    for j = 1 : size(train(:, 2:end-1), 1)
        similarity = int32(sum(train(j, 2:end-1) .* valid(i, 2:end-1)));
        if similarity > bestsSoFar{i, 1}
            bestsSoFar{i, 1} = similarity;
            bestsSoFar{i, 2} = train(j, 1);
        elseif similarity == bestsSoFar{i, 1}
            bestsSoFar{i, 2}(end + 1) = train(j, 1);
        end;
    end;
end;

best_trains_for_valid = bestsSoFar;

end