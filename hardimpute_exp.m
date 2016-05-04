clear
data = imread('Samoa.JPG');
data = im2double(data);
long_data = data(:, :, 1);
long_data = long_data(:);
[~, idx_to_remove] = datasample(1:size(long_data, 1), floor(size(long_data, 1)/2),...
        'Replace', false);
r_arr = [1, 5, 10, 15, 20, 25, 30];
errors = zeros(3, size(r_arr, 2));
X_impute = {};
for i = 1:3
    noisy = data(:, :, i);
    figure
    subplot(3, 3, 1)
    imshow(data(:, :, i), 'InitialMagnification', 100);
    title1 = sprintf('Original channel %d', i);
    title(title1)
    noisy = noisy(:);
    noisy(idx_to_remove) = 0;
    noisy = reshape(noisy, [128 128 1]);
    subplot(3, 3, 2)
    imshow(noisy, 'InitialMagnification', 100)
    title('50% zeros')
    omega = noisy == 0;

    for j = 1:size(r_arr, 2)
        X_impute{i, j} = hardimpute(noisy, omega, r_arr(j));
        subplot(3, 3, j + 2)
        imshow(X_impute{i, j}, 'InitialMagnification', 100)
        title3 = sprintf('r = %d', r_arr(j));
        title(title3)
        pause(1)
        errors(i, j) = norm(X_impute{i} - noisy)^2;
    end
end

colors = {};
figure
subplot(3, 3, 1)
imshow(data, 'InitialMagnification', 100)
title('Original Image')
for i = 1:7
    temp = zeros(size(data));
    temp(:, :, 1) = X_impute{1, i};
    temp(:, :, 2) = X_impute{2, i};
    temp(:, :, 3) = X_impute{3, i};
    colors{i} = temp;
    subplot(3, 3, i+1)
    imshow(temp, 'InitialMagnification', 100);
    title4 = sprintf('r = %d', r_arr(i));
    title(title4)
end