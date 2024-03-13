function [conv_circ, conv_lin] = dftconv(h, x, N)
    % Obliga a que h y x sean vectores columna. Las salidas conv_circ y conv_lin también lo serán
    x=x(:);
    h=h(:);

    % Obtiene la longitud de h y x
    lx = length(x);
    lh = length(h);

    % Comprueba que N es mayor o igual que las longitudes de h y de x
    if N < max([lx lh])
        error('N debe ser como minimo igual a la longitud de la señal mas larga.')
    end

    % Calcula la convolucion circular de N puntos mediante la FFT y la almacena en conv_circ
    conv_circ = ifft(fft(h,N).*fft(x,N));

    % Calcula la convolucion lineal con FFTs rellenando con ceros de forma adecuada y la almecena en conv_lin
    % add zeros to the end of the signal
    N = lx + lh - 1;

    x = [x; zeros(N-lx,1)];
    h = [h; zeros(N-lh,1)];

    % calculate the linear convolution
    conv_lin = ifft(fft(h, N).*fft(x, N));
end
