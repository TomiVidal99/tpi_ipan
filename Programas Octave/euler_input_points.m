% metodo de Euler para resolver una ecuacion diferencial ordinaria de orden 2, aplicando un cambio de variable

function [aproximated_points] = euler_input_points(equation, initial_conditions, interval, step)

    aproximated_points = NaN;

    t = [interval(1):step:interval(2)];
    X(1) = initial_conditions(1);
    U(1) = initial_conditions(2);

    for (i = 1:(length(t)-1))
        X(i+1) = X(i) + step*U(i);
        U(i+1) = U(i) + step*equation(i+1, X(i), U(i));
    end

    aproximated_points = [transpose(t), transpose(X)];

end
