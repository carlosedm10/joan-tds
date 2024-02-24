function [y, fc, B, xL, xF, xG]  = interpolador_racional(x,L,M)
    % Entradas:
    % x, senyal que se va a interpolar
    % L, factor de interpolación
    % M, factor de diezmado
    % Salidas:
    % y, senyal interpolada
    % fc, B, xL, xF, xG variables para comprobacion automatica del programa

    % Obliga a que la salida sea un vector columna
    x = x(:);

    % Calcula la frecuencia de corte del filtro
    fc = 1 / (2 * max(L, M));

    N = 80;

    % Calcula los coeficienets del filtro paso bajo
    Wn = 2 * fc;
    B = fir1(N, Wn);

    % Inserta ceros mediante la función inserta_ceros. Hay que definirla abajo
    xL = inserta_ceros(x, L);

    % Filtra la señal xL con el filtro paso bajo diseñado
    xF = filter(B, 1, xL);

    % Aplica la ganancia del filtro a la señal xF
    xG = xF * L;

    % Diezma mediante la función diezmador. Hay que definirla abajo
    y = diezmador(xG, M);
end
