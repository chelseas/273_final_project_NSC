function u = baseline_control(dt, t, tmax, time, x_hat)
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
    
%%


end