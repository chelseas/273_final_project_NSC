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

if feat_checks(end) == 0 % only true if we've visited all features
    feat_target = [0;0];
else
    ind = find(feat_checks,1); % index of first unvisited feature.
    feat_vec = x_hat(2*ind-1+3:2*ind+3); % first unvisited feat
    if norm(feat_vec-r_pos) < 1 % if we're close to this feature
        feat_checks(ind) = 0; % mark need to visit = false
        if feat_checks(end) == 0 % if all features have NOW been visited
            feat_target = [0;0]; % go home
        else % if there are more features to visit, visit them
            feat_target = x_hat(2*ind+1+3:2*ind+2+3);
        end
    else % if we're not close to the next feature, head towards it
        feat_target = feat_vec;
    end
end

[vel, omega] = go_to_feat(feat_target);

u = [vel; omega];        
u = saturate(u);
    
function [vel, omega] = go_to_feat(feat_pos)
    ang = get_angle_to_feat(r_pos, feat_pos);
    ang_dif = robot_heading - ang;
    ang_dif = ang_dif*180/pi;
    %fprintf('Robot angle to x: %.2f  ', robot_heading*180/pi)
    %fprintf('Feature heading: %.2f \n', ang*180/pi)
    %fprintf('Robot angle - angle to feat: %.3f\n', ang_dif);
    % if not pointed in direction of feature
    if ( ((ang_dif > 270) && (ang_dif < 330)) || ((ang_dif < -30) && (ang_dif > -180) ))
        omega = 20;
        vel = 0;
    elseif ( ((ang_dif > 30) && (ang_dif < 180) ) || ( (ang_dif < -180) && (ang_dif > -330) ) )
        omega = -20;
        vel = 0;
    else
        vel = 10;
        omega = 0;
    end
    % cos(.5*(abs(ang_dif)+3*pi))
end

    function ang = get_angle_to_feat(r,f)
        dif_vec = f-r;
        ang = atan2( dif_vec(2), dif_vec(1));
        ang = mod(ang, 2*pi);
    end

end