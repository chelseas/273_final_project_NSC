% a final project
% brought to you in three acts

% init sim parameters

% init containers

% main simulation loop

% for each timestep 

    % propogate dynamics
    [next_state] = propogate_dynamics(prev_state, velocity, rotation_rate, dt);
    
    % measure + estimate state
    add_noise = true;
    measurement = get_measurement(state, meas_noise_cov, add_noise);
    [state, cov] = get_estimate(x, y, z);
    
    % do active control
    [control] = get_control(a,b,c);

    
% end for

% plot stuff (call plot stuff function)
