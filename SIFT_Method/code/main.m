FEATURE = 'bag of sift';

CLASSIFIER = 'support vector machine';

run('vlfeat/toolbox/vl_setup')

data_path = '../data/'; %The data path of hand gesture

data_path = '../data2/'; %The data path for views

%This is the hand gesture categories.
categories = {'1', '2', '3', '4', '5', '6', '7', ...
    '8', '9', '10','A', 'B', 'C', 'D', 'E'};
%This list of shortened category names is used later for visualization.
abbr_categories = {'1', '2', '3', '4', '5', '6', '7', ...
    '8', '9', '10','A', 'B', 'C', 'D', 'E'};


%the catergories for our control group.
%categories = {'Kitchen', 'Store', 'Bedroom', 'LivingRoom', 'Office', ...
%      'Industrial', 'Suburb', 'InsideCity', 'TallBuilding', 'Street', ...
%      'Highway', 'OpenCountry', 'Coast', 'Mountain', 'Forest'};
   
%This list of shortened category names is used later for visualization.
%abbr_categories = {'Kit', 'Sto', 'Bed', 'Liv', 'Off', 'Ind', 'Sub', ...
%    'Cty', 'Bld', 'St', 'HW', 'OC', 'Cst', 'Mnt', 'For'};

num_train_per_cat = 100; 

%This function returns cell arrays containing the file path for each train
%and test image, as well as cell arrays with the label of each train and
%test image. 
fprintf('Getting paths and labels for all train and test data\n')
[train_image_paths, test_image_paths, train_labels, test_labels] = ...
    get_image_paths(data_path, categories, num_train_per_cat);
    

%% Step 1: Represent each image with the appropriate feature
% Each function to construct features should return an N x d matrix, where
% N is the number of paths passed to the function and d is the 
% dimensionality of each image representation. 

fprintf('Using %s representation for images\n', FEATURE)

switch lower(FEATURE)    
    case 'tiny image'
        % YOU CODE get_tiny_images.m 
        train_image_feats = get_tiny_images(train_image_paths);
        test_image_feats  = get_tiny_images(test_image_paths);
        
    case 'bag of sift'
        % YOU CODE build_vocabulary.m
        % Must build vocabulary, appears to be 400 "words", each 128
        % values
        if ~exist('vocab.mat', 'file')
            fprintf('No existing visual word vocabulary found. Computing one from training images\n')
            vocab_size = 510; %Larger values will work better (to a point) but be slower to compute
            vocab = build_vocabulary(train_image_paths, vocab_size);
            save('vocab.mat', 'vocab')
        end
        
        % YOU CODE get_bags_of_sifts.m
        train_image_feats = get_bags_of_sifts(train_image_paths);
        test_image_feats  = get_bags_of_sifts(test_image_paths);
        
    case 'placeholder'
        train_image_feats = [];
        test_image_feats = [];
        
    otherwise
        error('Unknown feature type')
end



%% Step 2: Classify each test image by training and using the appropriate classifier


fprintf('Using %s classifier to predict test set categories\n', CLASSIFIER)

switch lower(CLASSIFIER)    
    case 'nearest neighbor'
        %nearest_neighbor_classify.m 
        predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats);
        
    case 'support vector machine'
        %svm_classify.m 
        predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats);
        
    case 'placeholder'
        %The placeholder classifier simply predicts a random category for every test case
        random_permutation = randperm(length(test_labels));
        predicted_categories = test_labels(random_permutation); 
        
    otherwise
        error('Unknown classifier type')
end



%% Step 3: Build a confusion matrix and score the recognition system

create_results( train_image_paths, ...
                test_image_paths, ...
                train_labels, ...
                test_labels, ...
                categories, ...
                abbr_categories, ...
                predicted_categories)
