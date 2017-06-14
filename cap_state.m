% wrap angles to the range [0...360]
function x = cap_state(x)
    if (x > 2*pi) || (x < 0)
        x = mod(x, 2*pi);
        fprintf('Wrapped angle\n');
    end
end