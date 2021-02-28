function [euler_points] = ej5(frequency)

    clc;

    euler_points = NaN;

    R = 2;
    L = 0.1;
    C = 250e-6;
    A = 10;
    %f = 22220;
    f = frequency;
    w = 2*pi*f;
    w1 = 20*2*pi;
    w2 = 200*2*pi;
    w3 = 2000*2*pi;
    w4 = 20000*2*pi;

    ue = @(x) A*sin(w*x);
    %ue = @(x) A*sin(w1*x) + A*sin(w2*x) + A*sin(w3*x) + A*sin(w4*x);
    %uepp = @(x) -A*(w1^2)*sin(w1*x) - A*(w2^2)*sin(w2*x) - A*(w3^2)*sin(w3*x) - A*(w4^2)*sin(w4*x);
    uepp = @(x) -A*(w^2)*sin(w*x);
    d2_us = @(x, us, dus) ( -(dus)/(R*C) - (us)/(L*C) + uepp(x) );
    initial_conditions_us = 0;
    initial_conditions_dus = 2*A*pi*f;

    % solucion analitica
    %m1 = [ -w^2+1/(L*C), -w/(R*C); w/(R*C), 1/(L*C)-w^2 ];
    %m2 = [ -A*w^2; 0];
    %alpha_and_beta = inv(m1)*m2;
    %Alpha = alpha_and_beta(1);
    %Beta = alpha_and_beta(2);
    %l1 = ( -1/(R*C) - sqrt( (1/(R*C))^2 - 4/(L*C) )) / (2);
    %l2 = ( -1/(R*C) + sqrt( (1/(R*C))^2 - 4/(L*C) )) / (2);
    %c1 = ( 2*pi*A*f - Alpha*w + Beta*l2 ) / ( l1 - l2);
    %c2 = (( - 2*pi*A*f + Alpha*w - Beta*l2 ) / ( l1 - l2)) - (Beta);
    %us = @(x) c1*exp(l1*x) + c2*exp(l2*x) + Alpha*sin(w*x) + Beta*cos(w*x);

    h = 1e-7;
    interval = [0, 3e-3];
    t = [interval(1):h:interval(2)]; % vector del tiempo
    stepms = (3)/(length(t)-1); % el paso en milisegundos
    tms = [0:stepms:3]; % vector del tiempo en milisegundos

    % aproximo la solucion por el metodo de Euler
    [euler_points] = euler(d2_us, [initial_conditions_us, initial_conditions_dus], interval, h);

    hold off;
    plot(tms, euler_points(:, 2), 'r;Us(t);'); 
    hold on;
    plot(tms, ue(t), 'color', [0.1, 1, 0.1], ';Ue(t);');

    xlabel('Tiempo (milisegundos)', 'FontSize', 28);
    ylabel('Voltage (Volts)', 'FontSize', 28);
    set([gca; findall(gca, 'Type','text')], 'FontSize', 24);
    set([gca; findall(gca, 'Type','text')], 'FontName', 'Times New Roman');
    set([gca; findall(gca, 'Type','line')], 'linewidth', 2);

    str_title = cstrcat('Frecuencia: ', num2str(f), 'Hz');
    title(str_title);
    %save_plots(cstrcat('frecuencia ', num2str(f)), 'ej5');

end
