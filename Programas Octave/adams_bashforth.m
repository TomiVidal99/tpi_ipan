function [aproximated_points] = adams_bashforth(f1, f2, initial_conditions, interval, step)

    aproximated_points = NaN;

    t = [interval(1):step:interval(2)];
    y1(1) = initial_conditions(1, 1);
    y1(2) = initial_conditions(1, 2);
    y1(3) = initial_conditions(1, 3);
    y2(1) = initial_conditions(2, 1);
    y2(2) = initial_conditions(2, 2);
    y2(3) = initial_conditions(2, 3);

    for (n = 3:(length(t)-1))
        y1(n+1) = y1(n) + (step/12)*( 23*f1(t(n), y1(n), y2(n)) - 16*f1(t(n), y1(n-1), y2(n-1)) + 5*f1(t(n), y1(n-2), y2(n-2)) );
        y2(n+1) = y2(n) + (step/12)*( 23*f2(t(n), y1(n), y2(n)) - 16*f2(t(n-1), y1(n-1), y2(n-1)) + 5*f2(t(n-2), y1(n-2), y2(n-2)) );
    end

    aproximated_points = [transpose(t), transpose(y1)];

end
