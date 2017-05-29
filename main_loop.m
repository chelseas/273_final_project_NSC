% a final project
% brought to you in three acts

%%%%%%%%%%%%%%%%%%%%% Current Specifications %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state: [x_position, y_position, theta]
% control: [velocity, rotation_rate]
% filter used: UKF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init sim parameters
t_max = 20;
dt = 0.001;
time = 0:dt:t_max;

% init containers
state_dim = 3; 
x = zeros(3,length(time)); % the state
mu = zeros(3,length(time)); % the estimated state
sigma = zeros(3,3,length(time)); % the covariance

% initial filter state + real state
x(:,1) = [0,0,0];
mu(:,1) = [0,0,0];
sigma(:,:,1) = 1e6*ones(3,3); % very uncertain start state

% noise parameters
meas_noise_cov = 0.01; % R
process_noise_cov = 0.01*diag(ones(3,1));

% main simulation loop

% for each timestep 
for t = time(1:end-1)

    % propogate dynamics
    add_proc_noise = true;
    [next_state] = propogate_dynamics(prev_state, velocity, rotation_rate, dt, process_noise_cov, add_proc_noise);
    
    % measure + estimate state
    add_meas_noise = true;
    measurement = get_measurement(x(:,t), meas_noise_cov, add_meas_noise);
    [state, cov] = get_estimate(x, y, z);
    
    % do active control
    [control] = get_control(a,b,c);

% end for
end

% plot stuff (call plot stuff function)
