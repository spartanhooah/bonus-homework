function [X_complete] = hardimpute(X_missing, Omega, r)
% Input:
% X_missing -- a m-by-n input matrix, only values at Omega
% Omega -- a m-by-n binary matrix, indicating location of the missing values
% r -- rank

P_X_Omega = X_missing;
Z_new = zeros(size(X_missing));
Z_old = Z_new;
singulars = svds(P_X_Omega, r);
epsilon = 0.1;
Z_star = {};

for i = 1:size(singulars)
    while true
        Z_old = Z_new;
        Z_Omega_perp = zeros(size(Z_old));
        Z_Omega_perp(~Omega) = Z_old(~Omega);
        [U, S, V] = svds(P_X_Omega + Z_Omega_perp);
        Z_new = U * S * V';
        if norm(Z_old - Z_new, 'fro')^2 / norm(Z_old, 'fro')^2 < epsilon
            break
        end
    end
    Z_star{i} = Z_new;
    Z_old = Z_new;
end
X_complete = Z_new;
end