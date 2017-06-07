% plot estimate vs true state
figure()
subplot(3,1,1);
plot(time, x(1,:), 'k-'); hold on;
plot(time, mu(1,:), 'b--'); 
title('x Tracking Over Time')
legend('true', 'estimate');
xlabel('time')
ylabel('x')
subplot(3,1,2);
plot(time, x(2,:), 'k-'); hold on;
plot(time, mu(2,:), 'b--'); 
title('y Tracking Over Time')
legend('true', 'estimate');
xlabel('time')
ylabel('y')
subplot(3,1,3);
plot(time, x(3,:), 'k-'); hold on;
plot(time, mu(3,:), 'b--'); 
title('theta Tracking Over Time')
legend('true', 'estimate');
xlabel('time')
ylabel('theta')

% plot objective over time
figure();
plot(time, objective_log);
title('Objective Value Over Time');
xlabel('time');
ylabel('Objective Value');


j = 1;
figure();
title('Log(StdDev) of Feature Estimates')
for i = 4:state_dim
     subplot(5,2,i-3)
     if mod(i,2) == 0
         loc = 'x';
         ind = j;
     else
         j = j+1;
         loc = 'y';
         ind = j-1;   
     end
     %plot(log(time), log(sqrt(squeeze(sigma(i,i,:)))));
     semilogx(sqrt(squeeze(sigma(i,i,:))));
     title(sprintf('Standard Deviation of Feature %d, %c', ind,loc));
     hold on;
     xlabel('time [log scale]')
     ylabel('Std Dev')
end