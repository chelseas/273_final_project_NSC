% a final project
% brought to you in three acts

%%%%%%%%%%%%%%%%%%%%% Current Specifications %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% state: [x_position, y_position, theta, m1x, m1y, m2x, m2y,...,m42x, m42y]
% control: [velocity, rotation_rate]
% filter used: UKF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
% init sim parameters
t_max = 20;
dt = 0.01;
time = 0:dt:t_max;

m1 = [0;0]; m2 = [10;0]; m3 = [10;10]; m4 = [0;10]; 

% init containers
state_dim = 3 + (42*2); 
state_dim = 3 + (4*2);
x = zeros(state_dim,length(time)); % the state
mu = zeros(state_dim,length(time)); % the estimated state
%sigma = zeros(state_dim,state_dim,length(time)); % the covariance
% velocity = zeros(1,length(time)); % velocity control
% rotation_rate = zeros(1,length(time)); % rotation control

%test control
velocity = 0.1*ones(1,length(time));
rotation_rate = zeros(1,length(time));

%niveta control
velocity = ones(1,length(time));
rotation_rate = sin(time);


% initial filter state + real state
x(1:3,1) = [2,3,0];
%x and y coordinates of map features
% x(4:end,1) = [5.0067,87.9267,16.9019,87.9267,17.0363,75.7901,5.0067,75.7901,...
%     10.7863,87.8003,5.0067,81.8584,11.0551,75.7901,17.1035,81.7320,26.0417,...
%     87.8003,35.7191,87.9267,45.9341,87.9267,46.0013,73.6410,46.0013,57.7118,...
%     36.0551,57.9646,26.1089,57.7118,26.0417,73.1353,42.9772,57.8382,28.9987,...
%     57.9646,32.2917,52.0228,36.7272,51.0114,40.1546,52.1492,55.0739,87.5474,...
%     60.9879,87.8003,67.1035,87.8003,67.1035,82.6169,66.9691,75.9166,61.4583,...
%     76.0430,55.0739,75.9166,55.0739,81.0999,58.9718,49.8736,65.2890,49.7472,...
%     70.8669,49.7472,70.9341,40.0126,71.0013,30.0253,65.6250,30.0253,59.1062,...
%     29.7724,58.9718,40.0126,50.0336,0.9482,27.9906,1.2010,27.9234,22.9456,36.3239,...
%     21.3021,45.3293,14.6018];

x(4:end,1) = [m1;m2;m3;m4];

mu(1:3,1) = [2,3,0];
%mu(4:end,1) = x(4:end,1)+ (rand()-0.5);
mu(4:end,1) = x(4:end,1);
%sigma(:,:,1) = 2*ones(state_dim,state_dim); % very uncertain start state
sigma(:,:,1) = 2*eye(state_dim);

% noise parameters
meas_noise_cov = 0.01*eye(4); % R
process_noise_cov = zeros(state_dim);
process_noise_cov(1:3,1:3) = 0.1*eye(3)*dt^2;

% main simulation loop
handle_1 = figure();
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
    [control] = get_control(state, cov, measurement, [velocity(t), rotation_rate(t)], finite_horizon, dt, process_noise_cov, meas_noise_cov);        velocity(t+1) = control(1); rotation_rate(t+1) = control(2);
    velocity(t+1) = control(1); rotation_rate(t+1) = control(2);
    mu(:,t+1) = state;
    sigma(:,:,t+1) = cov;
    plot_stuff()
    pause(dt)
end

plot_stuff_static()
