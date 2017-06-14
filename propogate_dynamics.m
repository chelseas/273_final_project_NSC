% dynamics function
% unicycle robot model
% state is [x_position, y_position, orientation]'
function [next_state] = propogate_dynamics(prev_state, velocity, rotation_rate, dt, noise_cov, add_noise)
    next_state = prev_state; %for shape purposes
    theta_t = prev_state(3);
    next_state(1:3) = prev_state(1:3) + dt*[velocity*cos(theta_t);...
                                  velocity*sin(theta_t);...
                                  rotation_rate];
    next_state(4:end) = prev_state(4:end);
    num_feats = (length(prev_state) - 3)/2;
    if abs(next_state(3)) > (abs(prev_state(3)) + 30*pi/180)
        fprintf('WHY JUMP SO LARGE>\n')
    end
    
    if add_noise
        wt = mvnrnd(zeros(3+num_feats*2,1),noise_cov);
        if wt(3) > 10*pi/180
            fprintf('big noise!\n')
        end
        next_state = next_state + wt';
    end                         
end