function x = unscentedTrans(lambda, mu, sigma)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

n = length(mu);
mu = reshape(mu,n,1);
m = sqrtm((n+lambda)*sigma);
X = mu * ones(1,n);
x = [mu, X + m, X - m] ;
end

