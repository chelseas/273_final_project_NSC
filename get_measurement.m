% measurement model
% measurement: range
function measurement = get_measurement(state, meas_noise_cov, add_noise)
    % written assuming state is [x_position, y_position, theta]
    scaled_meas_noise_cov = meas_noise_cov*norm(state(1:2));
    measurement = norm(state(1:2));
    
    if add_noise
        v_t = mvnrnd(0, scaled_meas_noise_cov);
        measurement = measurement + v_t;
    end
end