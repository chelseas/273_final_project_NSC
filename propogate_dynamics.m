% dynamics function
% unicycle robot model
% state is [x_position, y_position, orientation]'
function [next_state] = propogate_dynamics(prev_state, velocity, rotation_rate, dt)
    theta_t = prev_state(3);
    next_state = prev_state + dt*[velocity*cos(theta_t);...
                                  velocity*sin(theta_t);...
                                  rotation_rate];

end