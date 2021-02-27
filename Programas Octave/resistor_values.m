function [resistor_vals, medium_value] = resistor_values(N)
    resistor_vals = NaN;
    medium_value = NaN;
    n = 1;
    while (n < N)
        clc;
        [current_val, ec] = ej2_c(strcat('ej2-c-', num2str(n), '.png'), 'ej2-c');
        if (ec == 0)
            resistor_vals(n) = current_val
            n = n + 1;
        end
    end
    resistor_vals = transpose(resistor_vals);
    medium_value = sum(resistor_vals)/length(resistor_vals);
    data.resistor_vals = resistor_vals;
    data.medium_value = medium_value;
    save './../plots/ej2-c/values.mat' data
end
