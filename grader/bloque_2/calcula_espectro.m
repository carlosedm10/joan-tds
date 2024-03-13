function [X,f] = calcula_espectro(x, fs)
    % Calcular el modulo de la FFT de x de tamaño N siendo N
    % la potencia entera de 2 superior o igual al doble de la longitud de x

    % Establece el valor de N
    L = length(x);
    N = 2^nextpow2(2*L);


    % Calcula el módulo de la FFT y lo re-ordena --> X
    X = abs(fft(x, N));
    X = fftshift(X);
    size(X)

    % Genera el vector de frecuencias f que corresponde al resultado de la FFT entre -fs/2 y fs/2
    f = linspace(-fs/2, fs/2, N);
end
