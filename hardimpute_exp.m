clear
data = imread('Samoa.JPG');
temp = data(:, :, 1);
temp = temp(:);
[~, idx_to_remove] = datasample(1:size(temp, 1), size(temp, 1)/2, 'Replace', false);
temp(idx_to_remove) = 0;
data = reshape(temp, [128 128 1]);
