function [new_samples, signal, h] = ej6_a()

    new_samples = NaN;
    audioFile = load('./../TP_2020_archivos/audio.mat');
    signal = audioFile.sig;
    h = audioFile.h;

    %for (i = 1:length(signal))
        %new_sample = ej6(signal(i), h);
    %end

end
