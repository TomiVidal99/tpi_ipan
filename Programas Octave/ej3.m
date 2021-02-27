function [aprox_L, aprox_C, error_code] = ej3(plot_name)
    clc;
    
    error_code = 0;
    aprox_L = NaN;
    aprox_C = NaN;

    pvl = 5;
    ccms = 10;

    % defino los vectores de tiempo
    interval_a = 0;
    interval_b = 3e-3;
    samples = 201;
    step = (interval_b)/(samples-1);
    stepms = (3)/(samples-1); % el paso en milisegundos
    t = [interval_a:step:interval_b];
    tms = [0:stepms:3]; % vector del tiempo en milisegundos

    % defino las mediciones
    [Us] = mediciones_us(t, ccms, pvl);
    Ue = 10; % para t >= 0 Ue = 10
    Uc = Ue - Us;

    % mido las corrientes y calculo Ic
    [Il] = mediciones_iL(t, pvl, ccms);
    [Ir] = mediciones_iR(t, pvl, ccms);
    Ic = Il + Ir;

    [integral_Ic, error_code] = simpson_3_8(t, Ic);
    aprox_C = integral_Ic/Uc(length(Uc));

    [integral_Ul, error_code] = simpson_3_8(t, Us);
    aprox_L = integral_Ul/Il(length(t));

    % grafico los voltages Ue y Uc
    hold off;
    plot(tms, Us, 'b;U_e;');
    hold on;
    plot(tms, Uc, 'r;U_c;');

    % grafico Il, Ir e Ic
    plot(tms, Il, 'k;I_l;');
    plot(tms, Ir, 'm;I_r;');
    hold on; plot(tms, Ic, 'c;I_c;');
    xlabel('Tiempo (milisegundos)');
    ylabel('Voltage (Volts) / Amperaje (Amperes)');
    C_title = strcat('C=', num2str(aprox_C), ' L=', num2str(aprox_L));
    title(C_title);

    save_plots(plot_name, 'ej3')

end
