% active control piece
function [u_best, objective_val] = get_control(x, sig, y, u,finite_horizon, dt, Q, R, ...
    meas_noise_cov, add_meas_noise, mindists)

if ~finite_horizon
    objective = @objective_function;
    %One step horizon
    options = optimset('MaxFunEvals',100, 'Display', 'iter', 'TolX', 1e-15, 'TolF', 1e-15);
    u_best = fminsearch(objective, u, options);
    u_best = saturate(u_best);
    objective_val = objective_function(u_best);
end


    function [objective] = objective_function(u)
        vel = u(1); rot_rt = u(2);
        measurement = get_measurement(x, meas_noise_cov, add_meas_noise);
        mindists = get_min_distances(measurement, mindists);
        [mu, sigma] = get_estimate(x,sig,measurement,vel,rot_rt, dt, Q, R,state_dim);
        objective = log(det(sigma));
        objective = objective + max(eig(sigma));
        objective = objective + trace(sigma);
        objective = objective + log(det(5*sigma(1:3,1:3)) + det(sigma(4:end,4:end)));
        objective = objective + norm(mu(1:2)-mu(5:6));
        objective = objective + sum(mindists);
    end
end