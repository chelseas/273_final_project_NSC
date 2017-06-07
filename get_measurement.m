% measurement model
% measurement: range
function measurement = get_measurement(state, meas_noise_cov, add_noise, state_dim)
    % written assuming state is [x_position, y_position, theta]
    j = 1;
    for i = 4:2:state_dim
        % range measurements to features
        measurement(j) = norm(state(i:i+1)-state(1:2));
        j = j+1;
    end
    
    if add_noise
        % this scales the measurement noise by the size of the measurement
        % aka if we're far from features, measurement has proportional
        % uncertainty
        v_t = mvnrnd(zeros(5,1), meas_noise_cov);
        measurement = measurement' + v_t';
    end
end