function [euler_points, taylor_points, adams_bashforth_points, runge_kutta_points] = ej4()

    clc; close all;
    
    euler_points = NaN;
    taylor_points = NaN;
    adams_bashforth_points = NaN;
    runge_kutta_points = NaN;

    methods_figures = 1;
    errors_figures = 2;

    R = 2;
    L = 0.1;
    C = 250e-6;
    A = 10;
    df = 0;

    s0 = -1/(2*R*C);
    s1 = s0 - sqrt((s0)^2 - 1/(L*C));
    s2 = s0 + sqrt((s0)^2 - 1/(L*C));
    real_solution = @(x) (A/(s1-s2))*(s1*e.^(s1*x) + s2*e.^(s2*x));

    d2_us = @(x, us, dus) ( -dus/(R*C) - us/(L*C)); % ecuacion diferencial
    d3_us = @(x, dus, d2us) (-d2us/(R*C) - dus/(L*C));
    f1 = @(x, y1, y2) y2;
    f2 = @(x, y1, y2) ( -y2/(R*C) - y1/(L*C));

    initial_conditions_us = A;
    initial_conditions_dus = -A/(R*C);

    h = 1e-7;
    interval = [0, 3e-3];
    t = [interval(1):h:interval(2)]; % vector del tiempo
    %stepms = (3)/(length(t)-1); % el paso en milisegundos
    %tms = [0:stepms:3]; % vector del tiempo en milisegundos
    tms = 1000*t;

    % aproximo la solucion por el metodo de Euler
    [euler_points] = euler(d2_us, [initial_conditions_us, initial_conditions_dus], interval, h);

    % aproximo la solucion por el metodo de Taylor de orden 2
    [taylor_points] = taylor(d2_us, d3_us, [initial_conditions_us, initial_conditions_dus], interval, h);

    % aproximo con el metodo de adams bashforth
    initial_conditions_adams_bashforth = [ real_solution(t(1:3)); taylor_points(3,1:3) ];
    [adams_bashforth_points] = adams_bashforth(f1, f2, initial_conditions_adams_bashforth, interval, h);

    % aproximo la solucion por el metodo de Runge Kutta 4
    [runge_kutta_points] = runge_kutta(f1, f2, [initial_conditions_us, initial_conditions_dus], interval, h);

    % calculo los errores
    [euler_relative_error, euler_acumulated_error] = return_errors('Euler', euler_points, real_solution, errors_figures, 'r;Euler;');
    [taylor_relative_error, taylor_acumulated_error] = return_errors('Taylor 2do orden', taylor_points, real_solution, errors_figures, 'm;Taylor;');
    %[adams_bashforth_relative_error, adams_bashforth_acumulated_error] = return_errors('Adams Bashforth', adams_bashforth_points, real_solution, errors_figures, 'c;Adams Bashforth;');
    [runge_kutta_relative_error, runge_kutta_acumultad_error] = return_errors('Runge Kutta 4', runge_kutta_points, real_solution, errors_figures, 'k;Runge Kutta;');

    % grafico las curvas
    figure(methods_figures);
    hold off; plot(tms, real_solution(t), 'b;Solución analítica;'); hold on;
    plot(tms, euler_points(:, 2), 'r;Euler;');
    plot(tms, taylor_points(:, 2), 'm;Taylor;'); 
    plot(tms, adams_bashforth_points(:, 2), 'c;Adams Bashforth 3;');
    plot(tms, runge_kutta_points(:, 2), 'k;Runge Kutta 4;');

    save_plots('ej4-errores-2', 'ej4', errors_figures, 'Error relativo');
    %save_plots('ej4-metodos-2', 'ej4', methods_figures);

end

function [relative_error, acumulated_error] = return_errors(method_name, aprox_points, real_function, figureSemilog, color)
    relative_error = NaN;
    acumulated_error = NaN;

    relative_error = abs( real_function(aprox_points(:,1)) - aprox_points(:, 2) );
    acumulated_error = sum(relative_error);
    medium_relative_error = sum(relative_error)/length(relative_error);

    max_error = max(relative_error);
    min_error = min(relative_error);
    printf('%s: \n Error realivo medio %d max %d y min %d, error acumulado: %d \n', method_name, medium_relative_error, max_error, min_error, acumulated_error);

    if (exist('figureSemilog'))

        figure(figureSemilog);
        hold on;
        %semilogy(aprox_points(:,1)*1000, relative_error, color);
        plot(aprox_points(:,1)*1000, relative_error, color);

    end

end

