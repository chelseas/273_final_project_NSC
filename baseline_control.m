function [u, feat_checks] = baseline_control(x_hat, feat_checks)
%% Proportional Gain Controller
%     % get control history depending on current time
%     % send robot on rough path through features in order to get good
%     % estimates
%     K = .1;
%     decider = t/tmax;
%     if decider <0.25
%         ref = [80;20];
%     elseif ( (decider >= 0.25) && (decider < 0.5))
%         ref = [70;65];
%     elseif ( (decider >= 0.5) && (decider < 0.75))
%         ref = [15;60];
%     else
%         ref = [0;0];
%     end
%         
%     u = -K*(x_hat - ref);


%% Open-loop controller
    % head for rightmost features 
%     u = zeros(2, length(time));
%     u(1,1:100) = (80/(100*dt))*ones(1,100);
%     u(2,1:100) = zeros(1,100);
%     u(1,101) = 0;
%     u(2,101) = .2;
%     % head for top feature bunch
%     u(1,102:201) = (60/(100*dt))*ones(1,100);
%     u(2,102:201) = zeros(1,100);
%     u(:,202:length(time)) = zeros(2,length(time)-201);
%     
    %u = saturate(u);
    
%% head to each object
robot_heading = x_hat(3);
r_pos = x_hat(1:2);

% first update feature visited list
% if we haven't visited the first unvisited feature, head towards it

ind = find(feat_checks,1); % index of first unvisited feature.
feat_vec = x_hat(2*ind-1+3:2*ind+3);
if norm(feat_vec-r_pos) < 1
    feat_checks(ind) = 0; % mark need to visit = false
    feat_target = x_hat(2*ind+1+3:2*ind+2+3);
else
    feat_target = feat_vec;
end

[vel, omega] = go_to_feat(feat_target);

u = [vel; omega];        
u = saturate(u);
    
function [vel, omega] = go_to_feat(feat_pos)
    ang = get_angle_to_feat(r_pos, feat_pos);
    ang_dif = robot_heading - ang;
    % if not pointed in direction of feature
    if ((ang_dif > 0.5236) && (ang_dif < pi))
        % command max angular velocity
        % when close, turn more slowly
        omega = -1*cos(.5*(abs(ang_dif)+3*pi));
        vel = 0;
    elseif ang_dif < -0.5236
        omega = 1*cos(.5*(abs(ang_dif)+3*pi));
        vel = 0;
    else % head to target
        omega = 0;
        vel = 50;
    end
end

    function ang = get_angle_to_feat(r,f)
        dif_vec = f-r;
        ang = atan2( dif_vec(2), dif_vec(1));
        ang = mod(ang, pi);
    end

end