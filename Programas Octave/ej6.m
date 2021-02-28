function [new_samples] = ej6()

    clc;
    new_samples = NaN;

    audioFile = load('./../TP_2020_archivos/audio.mat');
    signals = audioFile.sig;
    h = audioFile.h;

    R = 2;
    L = 0.1;
    C = 250e-6;
    A = 10;
    f = sum(signals);

    ue = @(x) 0;
    for (i = 1:length(signals))
        ue = @(x) ue(x) + A*sin(2*pi*signals(i)*x);
    end

    % busco la segunda derivada de la señal de entrada con un metodo numerico
    uepp = @(x) 0;
    for (i = 1:length(signals))
        uepp = @(x) uepp(x) + (-A)*((2*pi*signals(i))^2)*sin(2*pi*signals(i)*x);
    end

    d2_us = @(x, us, dus) ( -(dus)/(R*C) - (us)/(L*C) + uepp(x) );
    initial_conditions_us = 0;
    initial_conditions_dus = 2*A*pi*f;

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

    %xlabel('Tiempo (milisegundos)', 'FontSize', 28);
    %ylabel('Voltage (Volts)', 'FontSize', 28);
    set([gca; findall(gca, 'Type','text')], 'FontSize', 24);
    set([gca; findall(gca, 'Type','text')], 'FontName', 'Times New Roman');
    set([gca; findall(gca, 'Type','line')], 'linewidth', 2);

    %str_title = cstrcat('Frecuencia: ', num2str(f), 'Hz');
    %title(str_title);
    %save_plots(cstrcat('frecuencia ', num2str(f)), 'ej5');

end


