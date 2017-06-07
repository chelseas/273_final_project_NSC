% a final project
% brought to you in three acts

%%%%%%%%%%%%%%%%%%%%% Current Specifications %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state: [x_position, y_position, theta, m1x, m1y, m2x, m2y,...,m42x, m42y]
% control: [velocity, rotation_rate]
% filter used: UKF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
% init sim parameters
t_max = 200;
dt = 0.01;
time = 0:dt:t_max;

load('features5.mat');%loads 5 features into the variable feats

% init containers
num_feats = length(feats)/2;
state_dim = 3 + (num_feats*2); 
x = zeros(state_dim,length(time)); % the state
mu = zeros(state_dim,length(time)); % the estimated state
%sigma = zeros(state_dim,state_dim,length(time)); % the covariance
% velocity = zeros(1,length(time)); % velocity control
% rotation_rate = zeros(1,length(time)); % rotation control
mindists = 1e4*ones(num_feats);


%test control
%velocity = 0.1*ones(1,length(time));
%rotation_rate = zeros(1,length(time));

%niveta control
velocity = ones(1,length(time));
rotation_rate = sin(time);


% initial filter state + real state
x(1:3,1) = [2,3,0];
%x and y coordinates of map features
x(4:end,1) = feats;

mu(1:3,1) = [2,3,0];
%mu(4:end,1) = x(4:end,1)+ (rand()-0.5);
mu(4:end,1) = x(4:end,1);
%sigma(:,:,1) = 2*ones(state_dim,state_dim); % very uncertain start state
sigma(:,:,1) = 2*eye(state_dim);

% noise parameters
meas_noise_cov = 0.01*eye(num_feats); % R
process_noise_cov = zeros(state_dim);
process_noise_cov(1:3,1:3) = 0.1*eye(3)*dt^2;

% main simulation loop
handle_1 = figure();
% for each timestep 
for t = 1:length(time)-1

    % propogate dynamics
    add_proc_noise = true;
    x(:,t+1) = propogate_dynamics(x(:,t), velocity(t), rotation_rate(t), dt, process_noise_cov, add_proc_noise,num_feats);
    
    % measure + estimate state
    add_meas_noise = true;
    measurement = get_measurement(x(:,t), meas_noise_cov, add_meas_noise, state_dim);
    
    [state, cov] = get_estimate(mu(:,t), sigma(:,:,t), measurement, velocity(t), rotation_rate(t), dt, process_noise_cov, meas_noise_cov,state_dim);
    mindists = get_min_distances(measurement, mindists);
    
    % do active control
    finite_horizon = false;
    [control] = get_control(state, cov, measurement, [velocity(t), rotation_rate(t)], finite_horizon, dt, process_noise_cov,...
        meas_noise_cov, meas_noise_cov, add_meas_noise, state_dim, mindists);        

    velocity(t+1) = control(1); rotation_rate(t+1) = control(2);
    mu(:,t+1) = state;
    sigma(:,:,t+1) = cov;
    plot_stuff()
    pause(dt)
end

plot_stuff_static()
