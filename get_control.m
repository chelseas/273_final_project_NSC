% active control piece
function [u_best, objective_val] = get_control(x, sig,y, u,finite_horizon, dt, Q, R, ...
     add_meas_noise, mindists)

if ~finite_horizon
    objective = @objective_function;
    %One step horizon
    options = optimset('MaxFunEvals',50, 'TolX', 1e-5, 'TolF', 1e-5);
    u_best = fminsearch(objective, u, options);
    u_best = saturate(u_best);
    objective_val = objective_function(u_best);
end


    function [objective] = objective_function(u)
        vel = u(1); rot_rt = u(2);
        [mu, sigma] = get_estimate(x,sig,y,vel,rot_rt, dt, Q, R);
        measurement = get_measurement(mu, R, add_meas_noise);
        mindists = get_min_distances(measurement, mindists);
        objective = 0;
        objective = objective + log(det(sigma));
        % objective = objective + max(eig(sigma));
        % objective = objective + trace(sigma);
        %objective = objective + log(det(5*sigma(1:3,1:3)) + det(sigma(4:end,4:end)));
        %objective = objective + sqrt((mu(4)-mu(1))^2 + (mu(5)-mu(2))^2);
        objective = objective + 5*sum(mindists);
    end
end