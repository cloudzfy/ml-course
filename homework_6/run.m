clear;
clc;

load('hw6_pca.mat');

eigenvecs_display;

data_compression;

classification;

clear;

load('hw6_hmm_train.mat');
load('hw6_hmm_test_normal.mat');
load('hw6_hmm_test_trojan.mat');

trace_stat;

training_model;

testing_model;