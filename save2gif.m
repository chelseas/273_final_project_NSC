nImages = 20;%length(time);

figure;
for idx = 1:nImages
    t = idx * floor(length(time)/nImages);
    plot_stuff();
    drawnow
    frame = getframe(1);
    im{idx} = frame2im(frame);
end
close;

filename = 'experiment1.gif'; % Specify the output file name
for idx = 1:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',300,'DelayTime',0.25);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.25);
    end
end