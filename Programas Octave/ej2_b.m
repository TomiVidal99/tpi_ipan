function [aprox_R, error_code] = ej2_b(plot_name)

    error_code = 0;
    pvl = 5;
    ccms = 10;

    samples = 22;
    interval_a = 0;
    interval_b = 3e-3;
    step = (interval_b)/(samples-1);
    stepms = (3)/(samples-1);

    % genero los vectores de tiempo t es en segundos y tms es en milisegundos
    t = [interval_a:step:interval_b];
    translation_constant = 1;
    tms = t*1000;

    % obtengo las mediciones con las características deseadas
    [Us_messurements] = mediciones_us(t, pvl, ccms);
    [iR_messurements] = mediciones_iR(t, pvl, ccms);

    % grafico los datos
    hold off;
    %plot(t, Us_messurements, 'db;Tensión U_s medida;');
    %hold on;
    plot(t+translation_constant, iR_messurements+translation_constant, 'dr;Corriente I_R medida;');

    % aproximo R por el metodo de minimos cuadrados
    polinome_grade = length(t);
    data = [transpose(t+translation_constant), iR_messurements+translation_constant]
    plot(data(1, :), data(2, :), 'm;data;');

    [f, error_code, aprox_R_complex, a0] = minimos_cuadrados_no_lineal(data, polinome_grade);
    % condiciono el verdadero valor
    aprox_R = abs(real(aprox_R_complex));
    if (aprox_R > 0)

        % grafico la tension aproximada a partir de la ley de ohm V = I*R 
        f = @(x) x*aprox_R;
        %plot(tms, f(iR_messurements), 'k;Tensión aproximada;');

        % guardo el grafico
        aprox_R = abs(real(aprox_R));
        title(strcat('Resistencia calculada: ', num2str(aprox_R)));

        if (exist('plot_name'))
            save_plots(plot_name, 'ej2-b');
            set(gca, 'fontsize', 26);
            set(gca, 'fontweight', 'bold');
        end

    else 
        disp('No se pudo calcular R');
        error_code = 1;
    end

end
