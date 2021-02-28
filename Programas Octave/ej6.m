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

    % Ue es signals pero en forma de puntos
    ue = signals;

    % busco la segunda derivada de la señal de entrada con un metodo numerico
    uepp(1:length(signals)) = 0;
    for (i = 1:(length(signals)-2))
        uepp(i) = ( ue(i+2) - 2*ue(i+1) + ue(i) ) / (h^2);
    end

    d2_us = @(n, us, dus) ( -(dus)/(R*C) - (us)/(L*C) + uepp(n) );
    initial_conditions_us = 0;
    initial_conditions_dus = 0;

    a = 0;
    b = length(signals)*h + a - h;
    interval = [a, b];
    t = [a:h:b];

    % aproximo la solucion por el metodo de Euler
    [euler_points] = euler_input_points(d2_us, [initial_conditions_us, initial_conditions_dus], interval, h);


    hold off;
    plot(t, euler_points(:, 2), 'r;Us(t);'); 
    hold on;
    plot(t, ue, 'color', [0.1, 1, 0.1], ';Ue(t);');

    %xlabel('Tiempo (milisegundos)', 'FontSize', 28);
    %ylabel('Voltage (Volts)', 'FontSize', 28);
    set([gca; findall(gca, 'Type','text')], 'FontSize', 24);
    set([gca; findall(gca, 'Type','text')], 'FontName', 'Times New Roman');
    set([gca; findall(gca, 'Type','line')], 'linewidth', 2);

    %str_title = cstrcat('Frecuencia: ', num2str(f), 'Hz');
    %title(str_title);
    %save_plots(cstrcat('frecuencia ', num2str(f)), 'ej5');
    %outputFile = audioFile;
    %outputFile.sig = euler_points(:, 2);
    audiowrite('processed.wav', transpose(euler_points(:, 2)), 1/h);

end


