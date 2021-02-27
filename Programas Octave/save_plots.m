function save_plots(plot_name, sub_folder, figure_number, legendY)

    if (exist('figure_number'))
        h = figure(figure_number);
    else 
        h = figure(1);
    end

    % aplico la leyenda del grafico
    xlabel('Tiempo (ms)');
    ylabel('Voltage (V)');
    if (exist('legendY'))
        ylabel(legendY);
    end
    grid on; % uso grilla en el grafico

    set([gca; findall(gca, 'Type','text')], 'FontSize', 24);
    set([gca; findall(gca, 'Type','text')], 'FontName', 'Times New Roman');
    set([gca; findall(gca, 'Type','line')], 'linewidth', 2);

    cd './../plots/'
    cd(sub_folder)

    print(h, '-dpng', '-noui', '-S1076,824', plot_name);
    cd './../../Programas Octave/'
 
end
