% plot stuff: plotting utilities

% plot path of robot

h1 = plot(x(1,1:t), x(2,1:t),'k-'); hold on;
title('Path of robot');
h2 = plot(mu(1,1:t), mu(2,1:t), 'b--');
%ellipse_pts = get_error_ellipse(mu(1:2,:),sigma(1:2,1:2,:));
%for i = 1:length(time)
%    plot(ellipse_pts(1,:,i), ellipse_pts(2,:,i), 'k--');
%end
xlabel('x');
ylabel('y');

for i = 4:2:13
    h3 = plot(mu(i,1:t), mu(i+1,1:t), 'x');
    hold on;
end
%legend([h1,h2,h3],'True','Estimate','Features');
%plot(x(3,1:t), x(4,1:t), 'rx')
%plot(mu(3,1:t), mu(4,1:t), 'ro')
%plot(x(5,1:t), x(6,1:t), 'gx')
%plot(mu(5,1:t), mu(6,1:t), 'go')
legend([h1,h2,h3],'True','Estimate','Features');


