% active control piece

function [u_best] = get_control(x, sig, y, u,finite_horizon, dt, Q, R)

if ~finite_horizon
    objective = @objective_function;
    %One step horizon
    options = optimset('MaxFunEvals',50*2);
    u_best = fminsearch(objective, u, options);
end

    function [objective] = objective_function(u)
        vel = u(1); rot_rt = u(2);
        [mu, sigma] = get_estimate(x,sig,y,vel,rot_rt, dt, Q, R);
        %objective = log(det(sigma));
        %objective = max(eig(sigma));
        objective = trace(sigma);
    end
end