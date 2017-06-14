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

load('features5.mat');%loads 5 features into the variable feats

% init containers
num_feats = length(feats)/2;
state_dim = 3 + (num_feats*2);
x = zeros(state_dim,length(time)); % the state
mu = zeros(state_dim,length(time)); % the estimated state
sigma = zeros(state_dim,state_dim,length(time)); % the covariance
mindists = 1e4*ones(num_feats,1);


% test control
velocity = zeros(1,length(time));
rotation_rate = zeros(1,length(time));

% initial filter state + real state
x(1:3,1) = [2,3,0];
%x and y coordinates of map features
x(4:end,1) = feats;
mu(1:3,1) = [2,3,0];
mu(4:end,1) = x(4:end,1);
sigma(:,:,1) = 2*eye(state_dim) + .2*rand(state_dim);

objective_log = zeros(1, length(time));

% noise parameters
meas_noise_cov = 0.01*eye(num_feats); % R
meas_noise_cov(3,3) = 0; % theta noise should be much smaller
process_noise_cov = zeros(state_dim); % Q
process_noise_cov(1:3,1:3) = 0.1*eye(3)*dt^2;
process_noise_cov(3,3) = 0;


rng('default');

feat_checks = ones(1,5);

% main simulation loop
%handle_1 = figure();

active_control = true;
% for each timestep 
for t = 1:length(time)-1
    
    % propogate dynamics
    add_proc_noise = true;
    x(:,t+1) = propogate_dynamics(x(:,t), velocity(t), rotation_rate(t), dt, process_noise_cov, add_proc_noise);
    
    % measure + estimate state
    add_meas_noise = true;
    measurement = get_measurement(x(:,t), meas_noise_cov, add_meas_noise);
    
    [state, cov] = get_estimate(mu(:,t), sigma(:,:,t), measurement, velocity(t), rotation_rate(t), dt, process_noise_cov, meas_noise_cov);
    mindists = get_min_distances(measurement, mindists);
    
    if (state(3) > 2*pi) || (state(3) < 0)
        state(3) = mod(state(3), 2*pi);
        fprintf('Wrapped angle\n');
    %elseif state(3) < 0
    %    state(3) = mod(state(3), -2*pi);
    %    fprintf('Wrapped angle');
    end
    
   [u, feat_checks] = baseline_control(state, feat_checks);
    
    % do active control
    if active_control
        finite_horizon = true;
        add_meas_noise = false;
        [control, objective_val] = get_control(state, cov, measurement, [velocity(t), rotation_rate(t)], finite_horizon, dt, process_noise_cov,...
            meas_noise_cov, add_meas_noise, mindists);
        velocity(t+1) = mean(control(1) + u(1));
        rotation_rate(t+1) = mean(control(2) + u(2));
        objective_log(t) = objective_val;
        
        % add tracking piece TO active control
    else
        % first test tracking alone
        velocity(t+1) = u(1); rotation_rate(t+1) = u(2);
    end
    
    mu(:,t+1) = state;
    sigma(:,:,t+1) = cov;
    %pause(.000001);
    %delete([h1,h2,h3,h4,h5,h6]);
end

plot_stuff();
save2gif()
plot_stuff_static()
