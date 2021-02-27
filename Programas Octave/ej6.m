function [new_samples] = ej6(frequency, h, interval)

    clc;
    
    new_samples = NaN;
    euler_points = NaN;
    taylor_points = NaN;
    adams_bashforth_points = NaN;
    runge_kutta_points = NaN;

    R = 2;
    L = 0.1;
    C = 250e-6;
    A = 10;
    f = frequency;

    ue = @(x) A*sin(2*pi*f*x);
    s0 = -1/(2*R*C);
    s1 = s0 - sqrt((s0)^2 - 1/(L*C));
    s2 = s0 + sqrt((s0)^2 - 1/(L*C));
    v1 = 1/(L*C);
    v2 = (2*pi*f);
    A_ = [v1-v2^2, v2/(R*C); v1 - v2/(R*C), -(v2^2)];
    b_ = [-(A)*(v2^2); 0];
    alpha_and_beta = A_\b_;
    alpha = alpha_and_beta(1);
    beta = alpha_and_beta(2);
    particular_solution = @(x) alpha*sin(2*pi*f*x) + beta*cos(2*pi*f*x);
    homo_solution = @(x) (A/(s1-s2))*(s1*e.^(s1*x) + s2*e.^(s2*x));
    real_solution = @(x) homo_solution(x) + particular_solution(x);

    F = @(x) (A*((2*pi*f)^2)*sin(2*pi*f*x));
    d2_us = @(x, us, dus) ( -dus/(R*C) - us/(L*C) - F(x) ); % ecuacion diferencial
    d3_us = @(x, d_us, d2_us) (-d2_us/(R*C) - d_us/(L*C));
    initial_conditions_us = 0;
    initial_conditions_dus = 0;
    f1 = @(x, y1, y2) y2;
    f2 = @(x, y1, y2) -y2/(R*C) - y1/(L*C);
    
    %h = 1e-7;
    %interval = [0, 3e-3];
    t = [interval(1):h:interval(2)]; % vector del tiempo
    stepms = (3)/(length(t)-1); % el paso en milisegundos
    tms = [0:stepms:3]; % vector del tiempo en milisegundos

    % aproximo la solucion por el metodo de Euler
    %[euler_points] = euler(d2_us, [initial_conditions_us, initial_conditions_dus], interval, h);

    % aproximo la solucion por el metodo de Taylor de orden 2
    [taylor_points] = taylor(d2_us, d3_us, [initial_conditions_us, initial_conditions_dus], interval, h);

    % aproximo con el metodo de adams bashforth
    %initial_conditions_adams_bashforth = [ real_solution(t(1:3)); taylor_points(3,1:3) ];
    %[adams_bashforth_points] = adams_bashforth(f1, f2, initial_conditions_adams_bashforth, interval, h);

    % aproximo la solucion por el metodo de Runge Kutta 4
    %[runge_kutta_points] = runge_kutta(f1, f2, [initial_conditions_us, initial_conditions_dus], interval, h);

    %new_freq = [euler_points; taylor_points; adams_bashforth_points; runge_kutta_points];
    new_samples = taylor_points;

end
