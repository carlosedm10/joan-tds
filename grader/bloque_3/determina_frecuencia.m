function freq = determina_frecuencia(x, fs)
    % Calcular el modulo de la FFT de x de tamaño N siendo N
    % la potencia entera de 2 superior o igual al doble de la longitud de x
    N = 2^nextpow2(2*length(x));
    FFT = abs(fft(x, N));

    % Generar el vector de frecuencias que corresponde al resultado de la FFT
    freqs = (0:N-1)*fs/N;

    % Buscar el pico en la primera mitad del vector de la FFT
    [maxValue, indexMax] = max(FFT(1:N/2));

    % Obtener el valor de la frecuencia en Hz que corresponde a la posicion del pico
    freq = freqs(indexMax);
end
