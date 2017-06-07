    % saturate
    function sat_u = saturate(u)
        sat_u(1) = max( min( u(1), 10), -10); % linear velocity
        sat_u(2) = max( min( u(2), .2), -0.2); % angular velocity
    end