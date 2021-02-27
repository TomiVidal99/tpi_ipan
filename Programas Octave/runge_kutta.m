function [aproximated_points] = runge_kutta(f1, f2, initial_conditions, interval, step)

    aproximated_points = NaN;

    % vector que contiene la variable independiente
    x = [interval(1):step:interval(2)];
    y(1) = initial_conditions(1);
    w(1) = initial_conditions(2);

    % coeficientes de runge kutta
    b = [1, 2, 2, 1];

    for (i = 1:(length(x)-1))

        ky(1) = f1(x(i), y(i), w(i));
        kw(1) = f2(x(i), y(i), w(i));

        ky(2) = f1(x(i) + (step/2), y(i) + (step/2)*ky(1), w(i) + (step/2)*kw(1));
        kw(2) = f2(x(i) + (step/2), y(i) + (step/2)*ky(1), w(i) + (step/2)*kw(1));

        ky(3) = f1(x(i) + (step/2), y(i) + (step/2)*ky(2), w(i) + (step/2)*kw(2));
        kw(3) = f2(x(i) + (step/2), y(i) + (step/2)*ky(2), w(i) + (step/2)*kw(2));

        ky(4) = f1(x(i) + step, y(i) + step*ky(3), w(i) + step*kw(3));
        kw(4) = f2(x(i) + step, y(i) + step*ky(3), w(i) + step*kw(3));

        y(i+1) = y(i) + (step/6)*sum(b.*ky);       
        w(i+1) = w(i) + (step/6)*sum(b.*kw);       

    end

    aproximated_points = [transpose(x), transpose(y)];

end
