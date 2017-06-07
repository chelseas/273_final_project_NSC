% plot estimate vs true state
figure()
subplot(3,1,1);
plot(time, x(1,:), 'k-'); hold on;
plot(time, mu(1,:), 'b--'); 
subplot(3,1,2);
plot(time, x(2,:), 'k-');
plot(time, mu(2,:), 'b--'); 
subplot(3,1,3);
plot(time, x(3,:), 'k-');
plot(time, mu(3,:), 'b--'); 