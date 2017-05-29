function [objective] = objective_function(x,sig,y,w)
[mu, sigma] = get_estimate(x,sig,y,w);
objective = log(det(sigma));
end



