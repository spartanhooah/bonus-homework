clear
data = imread('Samoa.JPG');
data = im2double(data);
for i = 1:3
    noisy = data(:, :, i);
    figure
    subplot(1, 3, 1)
    imshow(noisy);
    title1 = sprintf('Original channel %d', i);
    title(title1)
    noisy = noisy(:);
    [~, idx_to_remove] = datasample(1:size(noisy, 1), size(noisy, 1)/2,...
        'Replace', false);
    noisy(idx_to_remove) = 0;
    noisy = reshape(noisy, [128 128 1]);
    subplot(1, 3, 2)
    imshow(noisy)
    title('50% zeros')
    omega = noisy == 0;
    r_arr = [1, 5, 10, 15, 20, 25, 30];

    for r = r_arr
        X_impute = abs(hardimpute(noisy, omega, r));
        subplot(1, 3, 3)
        imshow(X_impute)
        title3 = sprintf('r = %d', r);
        title(title3)
        pause(1)
    end
end