% active control piece

function [u_best] = get_control(@objective_function,u0, finite_horizon)
objective = objective_function(x,sig,y,w);
%One step horizon
u_best = fminunc(objective, u0);

%10 step horizon
if finite_horizon
    for i = 1:10
    %propogate the model, get the objective, %propogate the model, get the
    %objective (i times)
    %keep adding the objective
    u_best = fminunc(objective,u0);
    end
end
end