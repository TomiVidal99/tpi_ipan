function ej1_b
    %En este script para octave se calcula la tensión de salida para Us(t) analiticamente a partir de los datos medidos de la tensión

    % t e [0,3]ms GENERO LOS puntos de la variable independiente (tiempo [s])
    samples = 50
    step = (3e-3)/(samples-1);
    t = [0:step:3e-3];
    tms = t*1000;
    pvl = 0;
    ccms = 0;

    % genero los 25 puntos de datos de la variable dependiente (voltage [V])j
    [us] = mediciones_us(t, pvl, ccms);

    % interpolo con el metodo de lagrange
    data = [transpose(t), us];
    grade = length(data);
    [f_ue_lagrange, error_code] = lagrange(data, grade);

    % grafico el resultado
    hold off;
    plot(tms, f_ue_lagrange(t), 'r'); hold on;
    plot(tms, f_ue_lagrange(t), 'db');
    title(cstrcat('Método de Lagrange de grado ', num2str(grade)));
    save_plots('ej1-b', 'ej1');

end
