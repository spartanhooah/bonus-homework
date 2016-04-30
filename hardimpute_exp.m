clear
data = imread('Samoa.JPG');
data = im2double(data);
long_data = data(:, :, 1);
long_data = long_data(:);
[~, idx_to_remove] = datasample(1:size(long_data, 1), size(long_data, 1)/2,...
        'Replace', false);
r_arr = [1, 5, 10, 15, 20, 25, 30];
errors = zeros(3, size(r_arr, 2));
for i = 1:3
    noisy = data(:, :, i);
    figure
    subplot(1, 3, 1)
    imshow(data(:, :, i));
    title1 = sprintf('Original channel %d', i);
    title(title1)
    noisy = noisy(:);
    noisy(idx_to_remove) = 0;
    noisy = reshape(noisy, [128 128 1]);
    subplot(1, 3, 2)
    imshow(noisy)
    title('50% zeros')
    omega = noisy == 0;

    for j = 1:size(r_arr, 2)
        X_impute = abs(hardimpute(noisy, omega, r_arr(j)));
        subplot(1, 3, 3)
        imshow(X_impute)
        title3 = sprintf('r = %d', r_arr(j));
        title(title3)
        pause(1)
        errors(i, j) = norm(X_impute - noisy)^2;
    end
end