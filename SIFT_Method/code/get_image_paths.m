
function [train_image_paths, test_image_paths, train_labels, test_labels] = ... 
    get_image_paths(data_path, categories, num_train_per_cat)

num_categories = length(categories); %number of scene categories.

%This paths for each training and test image. 
train_image_paths = cell(num_categories * num_train_per_cat, 1);
test_image_paths  = cell(num_categories * num_train_per_cat, 1);

%The name of the category for each training and test image.
train_labels = cell(num_categories * num_train_per_cat, 1);
test_labels  = cell(num_categories * num_train_per_cat, 1);

for i=1:num_categories
   images = dir( fullfile(data_path, 'train', categories{i}, '*.jpg'));
   for j=1:num_train_per_cat
       train_image_paths{(i-1)*num_train_per_cat + j} = fullfile(data_path, 'train', categories{i}, images(j).name);
       train_labels{(i-1)*num_train_per_cat + j} = categories{i};
   end
   
   images = dir( fullfile(data_path, 'test', categories{i}, '*.jpg'));
   for j=1:num_train_per_cat
       test_image_paths{(i-1)*num_train_per_cat + j} = fullfile(data_path, 'test', categories{i}, images(j).name);
       test_labels{(i-1)*num_train_per_cat + j} = categories{i};
   end
end