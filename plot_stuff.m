% plot stuff: plotting utilities

% plot path of robot

figure();
h1 = plot(x(1,:), x(2,:)); hold on;
title('Path of robot');
h2 = plot(mu(1,:), mu(2,:), '--');
%ellipse_pts = get_error_ellipse(mu(1:2,:),sigma(1:2,1:2,:));
%for i = 1:length(time)
%    plot(ellipse_pts(1,:,i), ellipse_pts(2,:,i), 'k--');
%end
xlabel('x');
ylabel('y');

for i = 4:2:87
    h3 = plot(x(i,:), x(i+1,:), 'x');
end
legend([h1,h2,h3],'True','Estimate','Features');

