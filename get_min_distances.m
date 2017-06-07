function [ mindists ] = get_min_distances(measurement, mindists)
%Update the vector of minimum distances to each feature 

for i=1:length(measurement)
    if(mindists(i) > measurement(i))
        mindists(i) = measurement(i);
    end
end

end

