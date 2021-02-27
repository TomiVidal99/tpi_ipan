% HECHO POR TOMAS VIDAL
% el objectivo es aproximar una funcion dado un conjunto de puntos como datos

function [f, error_code, a1, a0] = minimos_cuadrados_no_lineal(data, grade)

    % data es el conjunto de puntos a los que se les quiere aproximar la funcion
    % se presumen que es de la forma de dos filas y n columnas

    % grade es el grado del polinomio que se quiere usar como aproximacion

    % apply_log es 0 o 1, donde es desactivado o activado respectivamente, y es para aplicar logaritmo a todos los valores de data

    %disp('data');
    %disp(data);

    error_code = 0;
    coeficients_a = 0;
    aproximation_function = 0;
    a1 = NaN;
    a0 = NaN;

    [data_rows, data_columns] = size(data); % defino las variables de dimension de la matriz dada

    % aplicar logaritmo a data
    disp(data);
    X = data(:, 1);
    Y = log(data(:, 2));

    N = data_rows;
    eq1 = 0;
    for (i = 1:N)
        eq1 = eq1 + X(i)*Y(i);
    end
    eq1 = N*eq1;
    a1 = ( eq1 - sum(X)*sum(Y) ) / ( N*sum(X.^2) - (sum(X).^2) );
    a0 = exp( Y(1) - a1*X(1) );

    % defino f
    f = @(x) a0 + a1.^x;

end
