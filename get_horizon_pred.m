function [x,sig] = get_horizon_pred(x, sig, velocity, rotation_rate, dt, Q, timesteps)
lambda = 2;
nx = size(x,1);
weight(1) = lambda/(nx + lambda);
weight(2:2*nx+1) = 1/(2 * (nx + lambda));

for i=1:timesteps
    X = unscentedTrans(lambda, x, sig); %sigma point
    Xnew = zeros(size(X));
    for j = 1:size(X,2)
        Xnew(:,j) = propogate_dynamics(X(:,j), velocity, rotation_rate, dt, Q, 0);
    end
    
    x = wmean(weight,Xnew);
    sig = wcov(weight,Xnew,Xnew) + Q;
end

end

