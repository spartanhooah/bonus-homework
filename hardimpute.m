function [X complete] = hardimpute(X_missing, Omega, r)
% Input:
% X_missing -- a m-by-n input matrix, only values at Omega
% Omega -- a m-by-n binary matrix, indicating location of the missing values
% r -- rank

P_X_Omega = X_missing;
Z_new = zeros(size(X_missing));
singulars = svds(P_X_Omega, r);

for lambda = singulars
    Z_old = Z_new;
    Z_Omega_perp = zeros(size(Z_old));
    Z_Omega_perp(~Omega) = Z_old(~Omega);
    [U, S, V] = svds(P_X_Omega + Z_Omega_perp);
    Z_new = U * S * V';
end

end