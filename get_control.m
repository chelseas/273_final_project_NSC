% active control piece

function [u_best] = get_control(x, sig, y, u,finite_horizon)

if ~finite_horizon
    objective = @objective_function;
    %One step horizon
    u_best = fminunc(objective, u);
end

%10 step horizon
%if finite_horizon
%    for i = 1:10
%propogate the model, get the objective, %propogate the model, get the
%objective (i times)
%keep adding the objective
%    u_best = fminunc(objective,u0);
%    end
%end

    function [objective] = objective_function(u)
        vel = u(1); rot_rt = u(2);
        [mu, sigma] = get_estimate(x,sig,y,vel,rot_rt);
        objective = log(det(sigma));
    end
end