function [eigenvecs] = get_sorted_eigenvecs(X)
    % input:
    %   X - N*D data matrix, each row as a data sample
    %       You must assume that the data samples are not zero-mean, thus you need to perform 
    %       data transformation on X to make sure that the samples have zero-mean (PCA algorithm assumption),
    %       before performing eigenvalue-eigenvector decomposition.
    %       You may use MATLAB built-in function 'eig' to perform eigenvalue-eigenvector decomposition.
    % output:
    %   eigenvecs: D*D matrix, normalized eigenvectors (with length=1) sorted based on its eigenvalue magnitude, 
    %              with d-th column corresponds to eigenvector with the d-th biggest eigenvalue
    %              (e.g. 1st column corresponds to eigenvector with the biggest eigenvalue,
    %               2nd column corresponds to eigenvector with 2nd biggest eigenvalue, etc.)
    %
    % CSCI 567 2015 Fall, Homework 6
    % (put your code here...)
    [N, D] = size(X);
    mu = sum(X) / N;
    X = X - ones(N, 1) * mu;
    [eigenvecs, eigenvals] = eig(X' * X);
    [~, ind] = sort(eigenvals * ones(D, 1), 'descend');
    eigenvecs = eigenvecs(:, ind);
end
