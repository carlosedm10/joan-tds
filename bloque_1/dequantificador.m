function y = dequantificador(x, nbits)
    % Calcular Delta
    delta = 1 / (2^(nbits - 1));

    % Calcular salida
    y = x .* delta;
end
