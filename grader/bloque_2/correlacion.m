function [Rxy,lags]=correlacion(x, y)
    % Función que calcula la correlación entre las secuencias x e y utilizando la FFT.
    %
    % Los argumentos de entrada de la función son:
    % - x: señal de tamaño Lx muestras
    % - y: señal de tamaño Ly muestras
    %
    % Los argumentos de salida de la función son:
    % - Rxy: correlación cruzada de tamaño 2*M-1 donde M=max(Lx,Ly).
    % - lags: vector de índices del mismo tamaño que Rxy entre -(M-1) y M-1
    %
    % IMPORTANTE: El tamaño de la FFT, N, debe ser tal que:
    %       N >= 2*M-1
    %       N debe ser potencia de 2

    % Hacemos que x e y sean siempre vectores columna
    x = x(:);
    y = y(:);

    % Calcula el tamaño de la DFT
    M = max(length(x),length(y));
    N = 2^nextpow2(2*M-1);

    % Calcula la correlacion mediante FFT
    Rxy = ifft(fft(x,N).*conj(fft(y,N)));

    % Desplaza circularmente la correlación con fftshift
    Rxy = fftshift(Rxy);

    % Elimina ceros al inicio y al final para que tenga longitud 2*M-1
    Rxy = Rxy(N/2 - M + 2 : N/2 +M);

    % Genera el vector de lags con la misma estructura y longitud que Rxy (columna)
    lags = (1-M : M-1)';
    size(lags)
end
