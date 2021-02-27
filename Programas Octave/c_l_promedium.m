% calculo el promedio de C y L a partir de calcular repetidas veces la capacitancia y la inductancia

function [C_promedium, L_promedium] = c_l_promedium(a, b, should_save_plot)
    % should_save_plot es 1 o 0, si se quiere guardar el plot
    N = b-a;
    c_list(1:N) = 0;
    l_list(1:N) = 0;
    k = 1;
    if (should_save_plot == 1)
        for (i = a:b)
            [L,C,ec] = ej3(i);
            c_list(k) = C;
            l_list(k) = L;
            k = k + 1;
        end
    else
        for (i = a:b)
            [L,C,ec] = ej3(0);
            c_list(k) = C;
            l_list(k) = L;
            k = k + 1;
        end
    end
    C_promedium = sum(c_list)/length(c_list);
    L_promedium = sum(l_list)/length(l_list);
end
