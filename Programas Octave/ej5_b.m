function ej5_b()

    clc; close all;

    p20 = ej5(20, 'k');
    p200 = ej5(200, 'r');
    p2000 = ej5(2000, 'b');
    p20000 = ej5(20000, 'g');

    hold off;
    sin_sum = p20(:, 2) + p200(:, 2) + p2000(:, 2) + p20000(:, 2);
    %hold on;
    %plot(p20(:, 1)*1000, sin_sum(:), 'b');
    A = 10;
    ue = @(x) A*sin(2*pi*20*x) + A*sin(2*pi*200*x) + A*sin(2*pi*2000*x) + A*sin(2*pi*20000*x);
    plot(p20(:, 1)*1000, ue(p20(:, 1)), 'b');

    save_plots('ej5-in-sum', 'ej5-b');

end
