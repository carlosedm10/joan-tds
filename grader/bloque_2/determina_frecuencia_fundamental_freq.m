function [f_fund,debug_info] = determina_frecuencia_fundamental_freq(x, finicio, ffin, fs)
    % Tomar las muestras correspondientes a 1 segundo de la señal
    L = fs;  
    x = x(1:L);
    
    N = 524288; % equivale a 2^19, potencia entera de dos y bastante mas grande que L
    
    % Calcular el módulo de la fft de x con N puntos
    X = abs(fft(x,N));

    % Calcular los valores de kinicio, kfin que corresponden al rango de frecuencias finicio, ffin
    % Recordar que el índice k de la FFT va de [0,...,N-1]
    % Emplear "round" para obtener los valores kinicio y kfin, no usar "ceil" ni "floor"
    kinicio = round(finicio/fs*N);
    kfin = round(ffin/fs*N);
    
    % Para cada valor de k en el intervalo [kinicio,kfin], sumar el modulo de las FFT 
    % que correspondan a los 5 primeros armónicos y encontrar su valor máximo
    % El índice que corresponde a dicho valor máximo será kmax_val (usar este nombre para la variable). 
    % Se pueden usar bucles. 
    for k = kinicio:kfin
        suma = 0;
        for i = 1:5
            suma = suma + X(k*i);
        end
        if k == kinicio
            max_suma = suma;
            kmax_val = k;
        else
            if suma > max_suma
                max_suma = suma;
                kmax_val = k;
            end
        end
    end

    % Calcular la frecuencia fundamental a partir del valor hallado kmax_val
    f_fund = kmax_val*fs/N;

    % Para la correccion automática
    debug_info = containers.Map;
    debug_info('kinicio') = kinicio;
    debug_info('kfin') = kfin;
    debug_info('kmax_val') = kmax_val;
end
