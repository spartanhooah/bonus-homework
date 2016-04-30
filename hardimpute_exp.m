clear
data = imread('Samoa.JPG');
data = im2double(data);
noisy = data(:, :, 1);
subplot(1, 3, 1)
imshow(noisy);
title1 = sprintf('Original channel %d', 1);
title(title1)
noisy = noisy(:);
[~, idx_to_remove] = datasample(1:size(noisy, 1), size(noisy, 1)/2, 'Replace', false);
noisy(idx_to_remove) = 0;
noisy = reshape(noisy, [128 128 1]);
subplot(1, 3, 2)
imshow(noisy)
title('50% zeros')
omega = noisy == 0;
r_arr = [1, 5, 10, 15, 20, 25, 30];

for r = r_arr
    X_impute = hardimpute(noisy, omega, r);
    subplot(1, 3, 3)
    imshow(X_impute)
    title3 = sprintf('r = %d', r);
    title(title3)
    pause(3)
end