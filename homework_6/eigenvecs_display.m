eigenvecs = get_sorted_eigenvecs(X.train);

figure(1);
for i = 1 : 8
    hold on;
    subplot(2, 4, i);
    imshow(double(reshape(eigenvecs(:,i), 16, 16)), []);
    hold off;
end