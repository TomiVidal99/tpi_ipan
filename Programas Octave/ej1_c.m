function [data, f_ue] = ej1_c(plot_name)
    % En este script para octave se calcula la tensión de salida para Us(t) analiticamente a partir de los datos medidos de la tensión
    % save_plot es 0 (NO) o 1 (SI) si se quiere guardar el grafico
    % plot_number es el numero del plot para colocar en el nombre

    format long; clc;

    % t e [0,3]ms GENERO LOS puntos de la variable independiente (tiempo [s])
    f_ue = NaN;
    samples = 51;
    step = (3e-3)/(samples-1);
    stepms = (3)/(samples-1);
    % voy a usar un cambio de escala de segundos a milisegundos
    t = [0:step:3e-3];
    tms = [0:stepms:3];
    pvl = 25;
    ccms = 50;

    % genero los 25 puntos de datos de la variable dependiente (voltage [V])
    [us] = mediciones_us(t, pvl, ccms);

    data = [transpose(t), us];
    diff_f = 6.65;
    data(:,1) = data(:,1);
    data(:,2) = data(:,2)+diff_f;
    % calculo la aproximacion con el metodo de minimos cuadrados aplicando ln a las muestras
    [f_ue_lagrange, error_code] = lagrange(data, length(data));

    new_data = data;
    new_data(1,1) = 2e-4; % cambio el valor de la variable independiente del primer punto de los datos para que no sea cero 
    %disp(new_data_val);
    [f_ue_minimos_cuadrados, ec] = minimos_cuadrados_no_lineal(new_data, 50, 1);

    % grafico el resultado con metodo de minimos cuadrados
    voltage_aproximado_con_minimos_cuadrados = f_ue_minimos_cuadrados(t) - diff_f; % le resto la diferencia que aplique previamente 

    hold off;
    plot(tms(1:(length(t)-1)), (f_ue_lagrange(t(1:(length(t)-1)))-diff_f), 'r;Método de Lagrange;');
    hold on;
    plot(tms, voltage_aproximado_con_minimos_cuadrados, 'k;Método de mínimos cuadrados;');

    % ploteo ultimo los datos asi quedan arriba del resto
    plot(tms, us, '*b;Puntos medidos;');

    save_plots(plot_name, 'archivos_adjuntos');

    data(:,3) = voltage_aproximado_con_minimos_cuadrados; % guardo el data los datos calculados por si los quiero usar para hacer pruebas

end
