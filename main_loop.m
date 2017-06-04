% a final project
% brought to you in three acts

%%%%%%%%%%%%%%%%%%%%% Current Specifications %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state: [x_position, y_position, theta]
% control: [velocity, rotation_rate]
% filter used: UKF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
% init sim parameters
t_max = 20;
dt = 0.01;
time = 0:dt:t_max;

% init containers
state_dim = 3; 
x = zeros(3,length(time)); % the state
mu = zeros(3,length(time)); % the estimated state
sigma = zeros(3,3,length(time)); % the covariance
% velocity = zeros(1,length(time)); % velocity control
% rotation_rate = zeros(1,length(time)); % rotation control

%test control
velocity = ones(1,length(time));
rotation_rate = zeros(1,length(time));

% initial filter state + real state
x(:,1) = [0,1,0.2];
mu(:,1) = [0,1,0.2];
sigma(:,:,1) = 1e5*ones(3,3); % very uncertain start state

% noise parameters
meas_noise_cov = 0.01; % R
process_noise_cov = 0.1*diag(ones(3,1))*dt^2;

% main simulation loop

% for each timestep 
for t = 1:length(time)-1

    % propogate dynamics
    add_proc_noise = true;
    x(:,t+1) = propogate_dynamics(x(:,t), velocity(t), rotation_rate(t), dt, process_noise_cov, add_proc_noise);
    
    % measure + estimate state
    add_meas_noise = true;
    measurement = get_measurement(x(:,t), meas_noise_cov, add_meas_noise);
    [state, cov] = get_estimate(mu(:,t), sigma(:,:,t), measurement, velocity(t), rotation_rate(t), dt, process_noise_cov, meas_noise_cov);
    
    
    % do active control
    finite_horizon = false;
    [control] = get_control(state, cov, measurement, [velocity(t), rotation_rate(t)], finite_horizon, dt, process_noise_cov, meas_noise_cov);   
    velocity(t+1) = control(1); rotation_rate(t+1) = control(2);
    mu(:,t+1) = state;
    sigma(:,:,t+1) = cov;
 
end