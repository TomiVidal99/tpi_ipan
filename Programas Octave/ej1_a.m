function ej1_a
    %En este script para octave se calcula la tensión de salida para Us(t) analiticamente a partir de los datos medidos de la tensión

    % t e [0,3]ms GENERO LOS 25 puntos de la variable independiente (tiempo [s])
    step = 0.000125;
    t = [0:step:3e-3];
    tms = t*1000;
    pvl = 0;
    ccms = 0;

    % genero los 25 puntos de datos de la variable dependiente (voltage [V])j
    [us] = mediciones_us(t, pvl, ccms);
    data = [transpose(t), us];
    grade = length(data);
    [f_ue_lagrange, error_code] = lagrange(data, grade);
    if (length(t) > 0)
        Ue_messurements = f_ue_lagrange(t);
    end

    % grafico el resultado
    hold off;
    plot(tms, f_ue_lagrange(t), 'r'); hold on;
    plot(tms, f_ue_lagrange(t), 'db');
    title(cstrcat('Método de Lagrange de grado ', num2str(grade)));
    save_plots('ej1', 'ej1');


end
