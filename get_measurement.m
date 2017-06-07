% measurement model
% measurement: range
function measurement = get_measurement(state, meas_noise_cov, add_noise)
    % written assuming state is [x_position, y_position, theta]
    j = 1;
    for i = 4:2:87
        % range measurements to features
        measurement(j) = norm(state(i:i+1)-state(1:2));
        j = j+1;
    end
    
    if add_noise
        % this scales the measurement noise by the size of the measurement
        % aka if we're far from features, measurement has proportional
        % uncertainty
        v_t = mvnrnd(zeros(42,1), meas_noise_cov*diag(measurement));
        measurement = measurement' + v_t';
    end
end