dt = 0.0001;
t = (0:dt:1)';
h = [0.01 0.02 0.05 0.1 0.3];

f_g = zeros(size(t,1),5);
f_e = zeros(size(t,1),5);
f_h = zeros(size(t,1),5);
for i = 1 : 5
    f_g = gaussian_kernel(x_tr, t, h(i));
    subplot(5, 3, i * 3 - 2);
    plot(t, f_g);
    title('Gaussian kernel')
    ylabel(['h = ', num2str(h(i))])
    f_e = epanechnikov_kernel(x_tr, t, h(i));
    subplot(5, 3, i * 3 - 1);
    plot(t, f_e);
    title('Epanechnikov kernel')
    f_h = histogram(x_tr, t, h(i));
    subplot(5, 3, i * 3);
    plot(t, f_h);
    title('Histogram')
end