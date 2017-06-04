function [objective] = objective_function(x,sig,y,velocity, rotation_rate)
[mu, sigma] = get_estimate(x,sig,y,velocity,rotation_rate);
objective = log(det(sigma));
end



