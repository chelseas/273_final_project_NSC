function all_points = get_error_ellipse(mu_list, sigma_list)
    [H,W] = size(mu_list);
    N=1000;
    all_points = zeros(H,N,W);
    for j = 1:W
        mu = mu_list(:,j); 
        sigma = sigma_list(:,:,j);
        theta = linspace(0,2*pi,N);
        P = 0.95;
        r = sqrt( log(1/ ((1-P)^2) ) );
        w(1,:) = r*cos(theta);
        w(2,:) = r*sin(theta);
        % w = [x1, x2, ...]
        %     [y1, y2, ...]
        for i=1:N
            % sigma^1/2 * w + mu = x
            all_points(:,i,j) =  sqrtm(sigma)*w(:,i) + mu;
        end
    end    
end