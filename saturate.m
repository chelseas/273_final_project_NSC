    % saturate
    function sat_u = saturate(u)
        sat_u(1) = max( min( u(1), 100), -100); % linear velocity
        sat_u(2) = max( min( u(2), 20), -20); % angular velocity in radians per 100 seconds
    end