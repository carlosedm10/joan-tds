function y = quantificador(x, nbits)
    % Comprueba si hay saturación y si la hay, recorta al rango [-1,1]
    over = find(x > 1);
    under = find(x < -1);

    if ~isempty(over)
        x(over) = 1;
    end

    if ~isempty(under)
        x(under) = -1;
    end

    % Realiza la cuantificacion. La salida es un número entero
    y = floor(x * 2^(nbits - 1) + 0.5);
end
