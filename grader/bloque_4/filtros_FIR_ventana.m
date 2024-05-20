fc = 0.2; % frecuencia de corte normalizada

%Coeficientes filtro 1
B1 = fir1(14, fc, 'low', rectwin(15));

%Coeficientes filtro 2
B2 = fir1(14, fc, 'low', hamming(15));

%Coeficientes filtro 3
B3 = fir1(30, fc, 'low', rectwin(31));

%Representacion respuestas impulsionales
figure(1)
subplot(311)
% Eje de tiempos discreto
n1 = 0:13;
plot(n1,B1);
xlim([0,30])
ylim([-0.1,0.6]) % ajustamos ejes
xlabel('n')
title('h1')
grid
subplot(312)
% Eje de tiempos discreto
n2 = 0:13;
plot(n2,B2);
xlim([0,30])
ylim([-0.1,0.6]) 
xlabel('n')
title('h2')
grid
subplot(313)
% Eje de tiempos discreto
n3 = 0:29;
plot(n3,B3);
xlim([0,30])
ylim([-0.1,0.6]) 
xlabel('n')
title('h3')
grid

%Calculo respuestas en frecuencia (use 512 puntos)
[H1, W1] = freqz(B1, 1, 512);
[H2, W2] = freqz(B2, 1, 512);
[H3, W3] = freqz(B3, 1, 512);


figure(2)
subplot(211)
%Convertimos W1 W2 a frecuencia normalizada
f1 = W1/(2*pi);
f2 = W2/(2*pi);
plot(f1,abs(H1),f2,abs(H2));
title('Comparacion H1 y H2')
legend('H1','H2')
ylim([0,1.2])
subplot(212)
%Convertimos W3 a frecuencia normalizada
f3 = W3/(2*pi);
plot(f1,abs(H1),f3,abs(H3));
title('Comparacion H1 y H3')
legend('H1','H3')
ylim([0,1.2])
