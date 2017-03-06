function demo_fast_sc(opt_choice)
% opt_choice = 1: use L1 penalty
% opt_choice = 2: use epslion-L1 penalty

if ~exist('opt_choice', 'var')
    opt_choice = 1;
end

% natural image data
%load ../data/IMAGES.mat
load ../data/IMAGES_RAW.mat
%X = getdata_imagearray(IMAGES, 14, 10000);
%X = getdata_imagearray(IMAGESr, 8, 100000);
X = getdata_imagearray(IMAGESr, 8, 4096);
%X = getdata_imagearray_all(IMAGESr, 8);
%X = getdata_imagearray_all(IMAGESr(:,:,4), 8);
%X = getdata_imagearray_all(IMAGESr(:,:,1), 8);

% sparse coding parameters
num_bases = 128;
beta = 0.4;
batch_size = 1000;
num_iters = 2;
if opt_choice==1
    sparsity_func= 'L1';
    epsilon = [];
elseif opt_choice==2
    sparsity_func= 'epsL1';
    epsilon = 0.01;
end

Binit = [];
fname_save = sprintf('../results/sc_%s_b%d_beta%g_%s', sparsity_func, num_bases, beta, datestr(now, 30));

% run fast sparse coding
[B S stat] = sparse_coding(X, num_bases, beta, sparsity_func, epsilon, num_iters, batch_size, fname_save, Binit);
