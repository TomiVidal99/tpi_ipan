% HECHO POR TOMAS VIDAL
% APROXIMA LA INTEGRAL DE LA FUNCION F POR EL METODO SIMPSON 1/3

function [aproximated_integral, error_code] = simpson_3_8(X, Y)
    % f es una funcion que depende de una variable.
    % X es un vector de longitud N que contiene los valores de la variable independiente en el intervalo en el que se va a integrar.
    % con este metodo no se puede integrar en un intervalo que se inicie menor a -1

    error_code = 0;
    aproximated_integral = NaN;
    N = length(X);
    n = N-1;
    step = abs(X(2)-X(1));
    a = X(1);
    b = X(N);

    if ( mod(n, 2) != 0 ) 
        % la division del intervalo en N-1 segmentos tiene que ser par
        error_code = 1;
        disp('ERROR: el numero de segmentos a integrar por el metodo de simpson debe ser par');
    else

        %step = (b-a)/(n);
        %X = [a:step:b];
        %Y = f(X);

        hold off;
        plot(X, Y, 'r'); hold on;
        plot(a, Y(1), 'db');
        plot(b, Y(N), 'db');
        h = (b-a)/(n);

        a0 = Y(1);
        a1 = 0;
        for (i = 2:(n/3))
            a1 = a1 + 3*( Y(3*i-2) + Y(3*i-1) );
        end
        a2 = 0;
        for (i = 2:((n/3)-1))
            a2 = a2 + 2*Y(3*i);
        end
        a3 = Y(N);

        aproximated_integral = (3*h/8)*( a0 + a1 + a2 + a3 );

    end
end
