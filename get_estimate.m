% estimation

% get estimates

function [state, cov] = get_estimate(x, y, z)

X = unscentedTrans(lambda, x, sig); %sigma point
for j = 1:size(X,2)
    Xnew(:,j) = propogate_dynamics(X(:,j));%todo: change these args
end

end