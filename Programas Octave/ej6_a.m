function [new_samples] = ej6_a(signal, h, interval)

    close all;

    N = length(signal);
    Fn = h/2;
    FTsignal = fft(signal)/N;
    Fv = linspace(0, 1, fix(N/2)+1)*Fn;
    Iv = 1:length(Fv);  

    figure(1);
    plot(Fv, FTsignal(Iv));
    grid;

    freqs = FTsignal(Iv);
    disp(length(freqs));
    disp(length(signal));

    new_samples = NaN;

    for (i = 1:2:length(signal))
        if (freqs(i) < 1e-6)
            new_samples(i) = 0;
            new_samples(i+1) = 0;
            %new_sample = ej6(freqs(i), h, interval, current_amplitude);
            %new_samples(i) = new_sample(2, 1);
        end
    end

    new_frequencies = fft(new_samples)/N;
    figure(2);
    plot(Iv, new_frequencies(Iv));
    grid;
    audiowrite('processed.wav', new_samples, 1/h);

    figure(3);
    plot(signal, 'b');
    figure(4);
    plot(new_samples, 'r');

end
