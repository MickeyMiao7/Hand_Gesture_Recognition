
function predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
categories = unique(train_labels); 
num_categories = length(categories);
scores = zeros([num_categories size(train_labels, 1)]);
for i=1:num_categories
   tmp = strcmp(train_labels, categories{i});
   tmp = tmp - (1-tmp);
   [W B] = vl_svmtrain(train_image_feats', tmp', .00001);
   scores(i, :) = W'*test_image_feats' + B;
end
predicted_categories = cell(size(train_labels));
parfor i=1:size(test_image_feats,1)
    image_scores = scores(:, i);
    label_index = find(image_scores==max(image_scores));
    predicted_categories{i}=categories(label_index);
end


