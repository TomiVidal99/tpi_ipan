% HECHO POR TOMAS VIDAL
% APROXIMA FUNCION POR MEDIO DE POLINOMIOS DE LAGRANGE

function [function_aproximated, error_code] = lagrange(data, polinome_grade)
    % dado un conjunto de puntos (data) de la forma la primera columna estan los puntos de la variable independiente y en la segunda los de la dependiente y dado un grado del polinomio deseado (polinome_grade) se devuelve la funcion que interpola los datos
    error_code = 0;
    function_aproximated = @(x) 0;

    % defino el vector X de los valores de la variable independiente
    X = data(1:end, 1);
    % defino el vector Y de los valores de la variable dependiente
    Y = data(1:end, 2);

    % defino las variables que contienen las dimensiones de data
    [data_rows, data_cols] = size(data);
    
    % verifico que data tenga las dimensiones correctas
    if (data_cols != 2 || data_rows < 2)
        error_code = 1;
        disp("ERROR: la matriz ingresada no tiene las dimensiones correctas")
    else
       if (polinome_grade < 0 || polinome_grade > 1000 || polinome_grade == 'max')
           error_code = 2;
           disp("ERROR: el grado de polinomio no es aceptable")
           disp('Se usara el maximo disponible: ');
           disp(data_rows);
           polinome_grade = data_rows;
       end
       for (n = 1:polinome_grade)
           product = @(x) 1;
           for (k = 1:polinome_grade)
               if (k != n)
                   product = @(x) ( product(x) .* ((x - X(k)) / (X(n) - X(k))));
               end
           end
           function_aproximated = @(x) ( function_aproximated(x) + ( Y(n) * product(x) ));
       end
    end
end
