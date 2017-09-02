function numeric = ConvertCategoricalToNumeric(categorical, catToNumber)

numeric = zeros(size(categorical));
for i = 1 : size(categorical, 1)
    cat = categorical(i);
    if ismember(cat, catToNumber.categories)
        num = catToNumber.numValues(catToNumber.categories == cat);
    else
        num = 1;
    end;
    numeric(i) = num;
end;

end