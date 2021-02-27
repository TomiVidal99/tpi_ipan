% generates n plots

function generate_plots(a,b)
    for (n = a:b)
        plot_name = cstrcat('ej1_c_', num2str(n));
        ej1_c(plot_name);
    end
end
