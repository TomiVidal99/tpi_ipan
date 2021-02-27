function [euler_points] = ej5(frequency, color)

    %clc; close all;
    
    euler_points = NaN;

    R = 2;
    L = 0.1;
    C = 250e-6;
    A = 10;
    f = frequency;

    ue = @(x) A*sin(2*pi*20*x) + A*sin(2*pi*200*x) + A*sin(2*pi*2000*x) + A*sin(2*pi*20000*x);
    %ue = @(x) A*sin(2*pi*20*x);
    s0 = -1/(2*R*C);
    s1 = s0 - sqrt((s0)^2 - 1/(L*C));
    s2 = s0 + sqrt((s0)^2 - 1/(L*C));
    v1 = 1/(L*C);
    v2 = (2*pi*f);
    A_ = [v1-v2^2, v2/(R*C); v1 - v2/(R*C), -(v2^2)];
    b_ = [-(A)*(v2^2); 0];
    alpha_and_beta = A_\b_;
    alpha = alpha_and_beta(1);
    beta = alpha_and_beta(2);
    particular_solution = @(x) alpha*sin(2*pi*f*x) + beta*cos(2*pi*f*x);
    homo_solution = @(x) (A/(s1-s2))*(s1*e.^(s1*x) + s2*e.^(s2*x));
    real_solution = @(x) homo_solution(x) + particular_solution(x);

    F = @(x) ue(x);
    d2_us = @(x, us, dus) ( -dus/(R*C) - us/(L*C) - F(x) ); % ecuacion diferencial
    initial_conditions_us = 0;
    initial_conditions_dus = 2*A*pi*f;

    h = 1e-7;
    interval = [0, 3e-3];
    t = [interval(1):h:interval(2)]; % vector del tiempo
    stepms = (3)/(length(t)-1); % el paso en milisegundos
    tms = [0:stepms:3]; % vector del tiempo en milisegundos

    % aproximo la solucion por el metodo de Euler
    [euler_points] = euler(d2_us, [initial_conditions_us, initial_conditions_dus], interval, h);

    % grafico las curvas
    %figure(methods_figures);
    %hold off; plot(tms, real_solution(t), 'b;Solución analítica;'); hold on;

    % señal de entrada
    %plot(tms, ue(t), ';Señal de Entrada;', 'color', [0.1, 0.9, 0.3]);
    hold on;
    plot(tms, euler_points(:, 2), color); 

    %title_str = strcat('Frecuencia: ', num2str(f), 'hz');
    %error_str = strcat('error-', num2str(f), 'hz');
    %disp(title_str);
    %title(title_str);

    save_plots('ej5-out-singles', 'ej5-b');
    %save_plots(strcat(title_str, '-ue-2'), 'ej5');
    %save_plots(error_str, 'ej5', errors_figures, 'Error relativo');

end


