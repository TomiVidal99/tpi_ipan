function [L_vals, C_vals, medium_value_L, medium_value_C, error_l, error_c] = generate_lyc(N)
    L_vals = NaN;
    C_vals = NaN;
    medium_value_L = NaN;
    medium_value_C = NaN;
    real_l = 0.1;
    real_c = 250e-6;
    n = 1;
    while (n < N)
        clc;
        [l, c, ec] = ej3(strcat('ej3-', num2str(n), '.png'));
        if (ec == 0)
            L_vals(n) = l;
            C_vals(n) = c;
            n = n + 1;
        end
    end
    L_vals = transpose(L_vals);
    C_vals = transpose(C_vals);
    medium_value_L = sum(L_vals)/length(L_vals);
    medium_value_C = sum(C_vals)/length(C_vals);
    error_l = (abs(medium_value_L-real_l)/(real_l))*100;
    error_c = (abs(medium_value_C-real_c)/(real_c))*100;
    
    data.L_vals= L_vals;
    data.C_vals= C_vals;
    data.medium_value_L = medium_value_L;
    data.medium_value_C = medium_value_C;
    data.error_L = error_l;
    data.error_C = error_c;

    save './../plots/ej3/values-ej3.mat' data
end
