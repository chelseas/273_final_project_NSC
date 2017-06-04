% plot stuff: plotting utilities

% plot path of robot

figure();
plot(x(1,:), x(2,:)); hold on;
title('Path of robot');
plot(mu(1,:), mu(2,:), '--');
%ellipse_pts = get_error_ellipse(mu,sigma);
%for i = 1:length(time)
 %   plot(ellipse_pts(1,:,i), ellipse_pts(2,:,i), 'k--');
%end
legend('True','Estimate');
xlabel('x');
ylabel('y');
