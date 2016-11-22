%This function will sample SIFT descriptors from the training images,
%cluster them with kmeans, and then return the cluster centers.

function vocab = build_vocabulary( image_paths, vocab_size )

images = cellfun(@imread, image_paths, 'UniformOutput', false);
a = im2single(images{1});
[locations, all_feats] = vl_dsift(a, 'fast', 'step', 50);
for i=2:(size(images,1));
b = im2single(images{i});
    [locations, feats] = vl_dsift(b, 'fast', 'step', 50);
    all_feats = cat(2, all_feats, feats);
end
[vocab assignments] = vl_kmeans(single(all_feats), vocab_size);

% The output 'vocab' should be vocab_size x 128. Each row is a cluster
% centroid / visual word.
% For each loaded image, get some SIFT features. 







