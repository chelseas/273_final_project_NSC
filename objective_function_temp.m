function [objective] = objective_function(x,sig,y,u)
velocity = u(1);
rotation_rate = u(2);
[mu, sigma] = get_estimate(x,sig,y,velocity,rotation_rate);
objective = log(det(sigma));
end



