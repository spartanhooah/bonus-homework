clear
load('ad_data.mat')
lambdas = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
[~, bootstraps] = bootstrp(1000, @mean, X_train);
probabilities = zeros(size(X_train, 2), size(lambdas, 2));
% Specify the options (use without modification).
opts.rFlag = 1; % range of par within [0, 1].
opts.tol = 1e-6; % optimization precision
opts.tFlag = 4; % termination options.
opts.maxIter = 5000; % maximum iterations.

for lambda = lambdas
    counts = zeros(size(X_train, 2), 1);
    for i = 1:1000
        [weights, ~] = LogisticR(X_train(bootstraps(:, i), :), y_train, lambda, opts);
        selected = find(weights ~= 0);
        counts(selected) = counts(selected) + 1;
    end
    probabilities(:, lambdas == lambda) = counts / 1000;
end

total_probability = max(probabilities, [], 2);