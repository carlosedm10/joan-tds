function y = retardo(x, m)
    % Entradas:
    % x, señal a retardar,
    % m, retardo
    %
    % Salidas:
    % y, señal retardada

    N = length(x);    
    y = zeros(1, N);

    if (m < N)
        y(m+1:N) = x(1:N-m);
    end
end
