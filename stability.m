clear
load('ad_data.mat')
lambdas = [0, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
[~, bootstraps] = bootstrp(1000, @corr, X_train);

for lambda = lambdas
    for i = 1:1000
        
    end
end