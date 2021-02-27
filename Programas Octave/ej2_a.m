function [aprox_R] = ej2_a(plot_name)

    clc;

    pvl = 0;
    ccms = 0;

    samples = 22;
    interval_a = 0;
    interval_b = 3e-3;
    step = (interval_b)/(samples-1);
    stepms = (3)/(samples-1);

    % genero los vectores de tiempo t es en segundos y tms es en milisegundos
    t = [interval_a:step:interval_b];
    tms = t*1000;

    % obtengo las mediciones con las características deseadas
    [Us_messurements] = mediciones_us(t, pvl, ccms);
    [iR_messurements] = mediciones_iR(t, pvl, ccms);

    % grafico los datos
    hold off;
    plot(tms, Us_messurements, 'db;Tensión U_s medida;');
    hold on;
    plot(tms, iR_messurements, 'dr;Corriente I_R medida;');

    % aproximo R por el metodo de minimos cuadrados
    polinome_grade = length(t);
    data = [transpose(t), iR_messurements];
    data(1,1) = 1.48e-4;
    [f, error_code, aprox_R, a0] = minimos_cuadrados_no_lineal(data, polinome_grade);

    % grafico la tension aproximada a partir de la ley de ohm V = I*R 
    f = @(x) (-1)*x*aprox_R;
    plot(tms, f(iR_messurements), 'k;Tensión aproximada;');

    % guardo el grafico
    aprox_R = abs(real(aprox_R));
    title(strcat('Resistencia calculada: ', num2str(aprox_R)));

    if (exist('plot_name'))
        save_plots(plot_name, 'ej2-a');
        set(gca, 'fontsize', 26);
        set(gca, 'fontweight', 'bold');
    end

end
