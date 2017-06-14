% plot stuff: plotting utilities

% plot path of robot

h1 = plot(x(1,1:t), x(2,1:t),'k-'); hold on;
h5 = plot(mu(1,t), mu(2,t), 'o', 'MarkerSize', 15, 'LineWidth', 3);
h6 = plot([mu(1,t), 50*cos(mu(3,t))+mu(1,t)], [mu(2,t), 50*sin(mu(3,t)) + mu(2,t)], 'LineWidth', 3);
title('Path of robot');
h2 = plot(mu(1,1:t), mu(2,1:t), 'b--');
%ellipse_pts = get_error_ellipse(mu(1:2,:),sigma(1:2,1:2,:));
%for i = 1:length(time)
%    plot(ellipse_pts(1,:,i), ellipse_pts(2,:,i), 'k--');
%end
xlabel('x');
ylabel('y');
% 
% plot(x(4,1:t), x(5,1:t), 'rx'); hold on;
% plot(mu(4,1:t), mu(5,1:t), 'ro')
% plot(x(6,1:t), x(7,1:t), 'gx')
% plot(mu(6,1:t), mu(7,1:t), 'go')
% plot(x(8,1:t), x(9,1:t), 'bx')
% plot(mu(8,1:t), mu(9,1:t), 'bo')
% plot(x(10,1:t), x(11,1:t), 'cx')
% plot(mu(10,1:t), mu(11,1:t), 'co')

for j = 1:5
    h3 = plot(feats(2*j-1), feats(2*j),'kx');
    text(feats(2*j-1), feats(2*j), sprintf('      Feature %d',j));
end
    
for i = 4:2:13
   h4 = plot(mu(i,1:t), mu(i+1,1:t), 'x');
   hold on;
end
legend([h1,h2,h3, h4],'Robot','Robot Estimate','Features','Feature Estimates');

axis equal


