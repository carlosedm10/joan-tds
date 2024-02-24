function y = diezmador(x, M)
    % Entradas:
    % x, senyal entrada
    % M, factor de diezmado
    %
    % Salidas:
    % y, senyal diezmada
        
    x = x(:); % Así nos aseguramos de que la entrada siempre sea un vector columna
    y = x(1:M:end);
end
