% attempt at simple path following control
% controller adapted from "Control of unicycle type robots"
% Carona, Aguiar, Gaspar (2008)

function u = path_follow(mu, ref, u_ref)
    %v_r = u_ref(1); w_r = u_ref(2); % some reference control input.
    v_r = 0;
    % ^ try: last time step, also try zero. try active control. 
    % unpack some stuff and set gains
    k1 = .5; k2 = .5; k3 = .1;
    x = mu(1); y = mu(2); theta = mu(3);
    xd = ref(1); yd = ref(2); theta_d = ref(3);
    %
    C = diag([cos(theta_d - theta), 1]);
    u1 = -k1*(xd - x);
    u2 = k2*v_r*sinc(theta_d - theta)*(yd - y) - k3*(theta_d-theta);
    
    u = C*u_ref - [u1; u2];
    
end


% next paper to try: http://journals.sagepub.com/doi/10.1177/0142331214537294
% how to tune gains?