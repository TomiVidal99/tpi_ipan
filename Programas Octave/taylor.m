function [aproximated_points] = taylor(d2_us, d3_us, initial_conditions, interval, step)

    aproximated_points = NaN;

    t = [interval(1):step:interval(2)];
    y0(1) = initial_conditions(1);
    y1(1) = initial_conditions(2);

    for (i = 1:(length(t)-1))
        y0(i+1) = y0(i) + step*y1(i) + ((step^2)/2)*d2_us(t(i), y0(i), y1(i));
        y1(i+1) = y1(i) + step*d2_us(t(i), y0(i), y1(i)) + ((step^2)/2)*d3_us(t(i), y0(i), y1(i));
    end

    aproximated_points = [transpose(t), transpose(y0), transpose(y1)];

end
