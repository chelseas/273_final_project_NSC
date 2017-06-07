% active control piece
function [u_best] = get_control(x, sig, y, u,finite_horizon, dt, Q, R, ...
    meas_noise_cov, add_meas_noise, mindists)


if ~finite_horizon
    objective = @objective_function;
    %One step horizon
    options = optimset('MaxFunEvals',100, 'Display', 'iter', 'TolX', 1e-15, 'TolF', 1e-15);
    u_best = fminsearch(objective, u, options);
    % saturate
    u_best(1) = max( min( u_best(1), 10), -10); % linear velocity
    u_best(2) = max( min( u_best(2), .2), -0.2); % angular velocity
end


    function [objective] = objective_function(u)
        vel = u(1); rot_rt = u(2);
        measurement = get_measurement(x, meas_noise_cov, add_meas_noise);
        [mu, sigma] = get_estimate(x,sig,y,vel,rot_rt, dt, Q, R);
        mindists = get_min_distances(measurement, mindists);
        %objective = log(det(sigma));
        %objective = max(eig(sigma));
        %objective = trace(sigma);

        %objective = log(det(5*sigma(1:3,1:3)) + det(sigma(4:end,4:end)));
        %objective = sqrt((mu(4)-mu(1))^2 + (mu(5)-mu(2))^2);
        objective = log(det(5*sigma(1:3,1:3)) + det(sigma(4:end,4:end))) + sum(mindists);

    end
end