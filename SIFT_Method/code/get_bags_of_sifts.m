

function image_feats = get_bags_of_sifts(image_paths)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.
% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram.


load('vocab.mat');
vocab_size = size(vocab, 2);
image_feats = zeros([1500 vocab_size]);
images=cellfun(@imread, image_paths, 'UniformOutput', false);
vocab_inv = vocab';
parfor i=1:(size(images,1))
    [locations feats] = vl_dsift(single(images{i}), 'fast', 'step', 5);
    D_matrix = zeros([1 vocab_size]);
    %feats is a 128 x 14000 w/e features in the image
    all_nearest = knnsearch(single(vocab_inv), single(feats'));
    for n=1:size(all_nearest, 1)
        nearest_vocab=all_nearest(n);
        D_matrix(nearest_vocab) = D_matrix(nearest_vocab)+1;
    end
    out = 1/norm(D_matrix)*D_matrix;
    image_feats(i, :) = out;
end

