% estimation

% get estimates

function [x, sig] = get_estimate(x, sig, y, velocity, rotation_rate, dt, Q, R)
lambda = 2;
nx = size(x,1);
weight(1) = lambda/(nx + lambda);
weight(2:2*nx+1) = 1/(2 * (nx + lambda));

%PREDICT
X = unscentedTrans(lambda, x, sig); %sigma point
Xnew = zeros(size(X));

for j = 1:size(X,2)
    Xnew(:,j) = propogate_dynamics(X(:,j), velocity, rotation_rate, dt, Q, 0);%todo: change these args
end

x = wmean(weight,Xnew);
sig = wcov(weight,Xnew,Xnew) + Q;

%UPDATE
clear X Xnew
X = unscentedTrans(lambda, x, sig);
for j=1:size(X,2)
    y_sample(j) = get_measurement(X(:,j), R, 0);
end

y_est = wmean(weight,y_sample);

cov_yy = wcov(weight,y_sample,y_sample)+R;
cov_xy = wcov(weight,X,y_sample);

x = x + (cov_xy*inv(cov_yy))*(y-y_est);
sig = sig - (cov_xy*inv(cov_yy))*cov_xy';

end