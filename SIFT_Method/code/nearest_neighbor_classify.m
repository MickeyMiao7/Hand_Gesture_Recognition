%This function will predict the category for every test image by finding
%the training image with most similar features. 
function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats)
% image_feats is an N x d matrix, where d is the dimensionality of the feature representation.

    IDX = knnsearch(train_image_feats, test_image_feats);
    predicted_categories = cell([size(test_image_feats, 1), 14]);
    for i=1:size(IDX,1)
        predicted_categories{i}=train_labels(IDX(i));
    end

