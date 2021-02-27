% metodo de Euler para resolver una ecuacion diferencial ordinaria de orden 2, aplicando un cambio de variable

function [aproximated_points] = euler(equation, initial_conditions, interval, step)
    % equation es la ecuacion diferencial de segundo orden despejada tal que: equation = d2f = df + f + a.
    % initial_conditions son las condiciones iniciales, initial_conditions(1) = f(Xo) y initial_conditions(2) = df(Xo), entonces equation = @(df, f, a)
    % interval es el intervalo en el que se quiere resolver la ecuacion, interval(1) = a y interval(2) = b.
    % step es el paso a usar, es decir: dt
    % iterations son las iteraciones que se quieren aplicar para mejorar la aproximacion

    aproximated_points = NaN;

    t = [interval(1):step:interval(2)];
    X(1) = initial_conditions(1);
    U(1) = initial_conditions(2);

    for (i = 1:(length(t)-1))
        X(i+1) = X(i) + step*U(i);
        U(i+1) = U(i) + step*equation(t(i), X(i), U(i));
    end

    aproximated_points = [transpose(t), transpose(X)];

end
