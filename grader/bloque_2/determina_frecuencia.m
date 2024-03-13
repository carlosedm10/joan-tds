function freq = determina_frecuencia(x, fs)
    % Calcular el modulo de la FFT de x de tamaño N siendo N
    % la potencia entera de 2 superior o igual al doble de la longitud de x
    N = 2^nextpow2(2*length(x));
    X = abs(fft(x, N));

    % Generar el vector de frecuencias que corresponde al resultado de la FFT
    f = linspace(0, fs, N);

    % Buscar el pico en la primera mitad del vector de la FFT
    [~, idx] = max(X(1:N/2+1));

    % Obtener el valor de la frecuencia en Hz que corresponde a la posicion del pico
    freq = f(idx);
end
