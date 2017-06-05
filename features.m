clear all; close all

rectangle('Position',[1 1 70 90])
axis([0 100 0 100])

hold on;
rectangle('Position',[26 58 20 30])

hold on;
rectangle('Position',[5 76 12 12])

hold on;
rectangle('Position',[55 76 12 12])


hold on;
rectangle('Position',[59 30 12 20])

hold on;
th = linspace( 0, -pi, 100);
R = 7;  
x = R*cos(th) + 36;
y = R*sin(th) + 58;
plot(x,y);

hold on;
x = repmat(28,[23 1]);
y = linspace(1,23,23);
plot(x,y)

hold on;
th = linspace( 0, pi/2, 100);
R = 22;  %or whatever radius you want
x = R*cos(th) + 28;
y = R*sin(th) + 1;
plot(x,y);

%%Feature points for map
x = [5.0067
   16.9019
   17.0363
    5.0067
   10.7863
    5.0067
   11.0551
   17.1035
   26.0417
   35.7191
   45.9341
   46.0013
   46.0013
   36.0551
   26.1089
   26.0417
   42.9772
   28.9987
   32.2917
   36.7272
   40.1546
   55.0739
   60.9879
   67.1035
   67.1035
   66.9691
   61.4583
   55.0739
   55.0739
   58.9718
   65.2890
   70.8669
   70.9341
   71.0013
   65.6250
   59.1062
   58.9718
   50.0336
   27.9906
   27.9234
   36.3239
   45.3293
];
y = [ 87.9267
   87.9267
   75.7901
   75.7901
   87.8003
   81.8584
   75.7901
   81.7320
   87.8003
   87.9267
   87.9267
   73.6410
   57.7118
   57.9646
   57.7118
   73.1353
   57.8382
   57.9646
   52.0228
   51.0114
   52.1492
   87.5474
   87.8003
   87.8003
   82.6169
   75.9166
   76.0430
   75.9166
   81.0999
   49.7472
   49.8736
   49.7472
   40.0126
   30.0253
   30.0253
   29.7724
   40.0126
    0.9482
    1.2010
   22.9456
   21.3021
   14.6018];
figure();
plot(x,y,'k.')


% 
% % Create a yellow triangle
% figure
% x = [0.25, 1.0, 1.0];
% y = [0.25, 0.25, 1.0];
% fill(x, y, 'w')
% hold on
% 
% % Create an orange diamond
% x = [2.0, 2.25, 2.0, 1.75];
% y = [1.25, 1.55, 2.25, 1.5];
% fill(x, y, 'w')
% 
% % Create a blue rectangle
% left = 3.0;
% right = left + 0.5;
% bottom = 1.0;
% top = bottom + 1;
% x = [left left right right];
% y = [bottom top top bottom];
% fill(x, y, 'w')
% 
% % Create a purple transparent circle
% xc = 3.0;
% yc = 1.0;
% r = 0.5;
% x = r*sin(-pi:0.1*pi:pi) + xc;
% y = r*cos(-pi:0.1*pi:pi) + yc;
% fill(x, y, 'w')
% 
% % Create a light blue star
% xc = 1.0;
% yc = 3.0;
% t = (-1/4:1/10:3/4)*2*pi;
% r1 = 0.5;
% r2 = 0.2;
% r = (r1+r2)/2 + (r1-r2)/2*(-1).^[0:10];
% x = r.*cos(t) + xc;
% y = r2 - r.*sin(t) + yc;
% fill(x, y, 'w')
% 
% %  Create a green transparent ellipse
% xc = 0.75;
% yc = 2.5;
% x = 0.4*sin(-pi:0.1*pi:pi) + xc;
% y = 0.7*cos(-pi:0.1*pi:pi) + yc;
% fill(x, y, 'w')
% 
% % Create a red stop sign
% t = (1/16:1/8:1)'*2*pi;
% x = 0.4*sin(t) + 3;
% y = 0.4*cos(t) + 3;
% fill(x, y ,'w')
% 
% % Set the axis limits
% axis([0 4 0 4])
% axis square
% 
% % Add a title
% title('Filled Polygons')