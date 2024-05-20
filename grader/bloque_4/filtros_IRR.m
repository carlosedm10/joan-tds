% Especificaciones comunes
fm = 2000;
fp = 200;
fs = 400;
Wp = 2*fp/fm;
Ws = 2*fs/fm;
Rp = 5;
Rs = 35;


% Filtro de Butterworth
[n1, Wn1] = buttord(Wp, Ws, Rp, Rs);
[B1, A1] = butter(n1, Wn1, 'low');

% Respuesta en frecuencia (N=512, valor por defecto)
[H1, W1] = freqz(B1, A1); 

%Filtro de cheb1
[n2, Wn2] = cheb1ord(Wp, Ws, Rp, Rs);
[B2, A2] = cheby1(n2, Rp, Wn2, 'low');

% Respuesta en frecuencia (N=512, valor por defecto)
[H2, W2] = freqz(B2, A2);

%Filtro de cheb2
[n3, Wn3] = cheb2ord(Wp, Ws, Rp, Rs);
[B3, A3] = cheby2(n3, Rs, Wn3, 'low');

% Respuesta en frecuencia  (N=512, valor por defecto)
[H3, W3] = freqz(B3, A3);

%Filtro elliptico
[n4, Wn4] = ellipord(Wp, Ws, Rp, Rs);
[B4, A4] = ellip(n4, Rp, Rs, Wn4, 'low');

% Respuesta en frecuencia  (N=512, valor por defecto)
[H4, W4] = freqz(B4, A4);

% Representacion en escala lineal
figure(1)
subplot(221)
% Conversion de W1 a hertzios
f1a = (W1*fm)/(2*pi);
plot(f1a, abs(H1))
axis([0,1000,0,1.1])
title('Filtro de Butterworh')
grid

subplot(222)
% Conversion de W2 a hertzios
f2a = (W2*fm)/(2*pi);
plot(f2a,abs(H2))
axis([0,1000,0,1.1])
title('Filtro de Chebyshev tipo I')
grid

subplot(223)
% Conversion de W3 a hertzios
f3a = (W3*fm)/(2*pi);
plot(f3a,abs(H3))
axis([0,1000,0,1.1])
title('Filtro de Chebyshev tipo II')
grid

subplot(224)

% Conversion de W4 a hertzios
f4a = (W4*fm)/(2*pi);
plot(f4a,abs(H4))
axis([0,1000,0,1.1])
title('Filtro elipitico')
grid

figure(2)
subplot(221)

%conversion a dBs
H1db = 20*log10(abs(H1)); 
plot(f1a, H1db)
axis([0,1000,-60,5])
title('Filtro de Butterworh  (dB)')
grid

subplot(222)

%conversion a dBs
H2db = 20*log10(abs(H2));
plot(f2a,H2db)
axis([0,1000,-60,5])
title('Filtro de Chebyshev tipo I (dB)')
grid

subplot(223)

%conversion a dBs
H3db = 20*log10(abs(H3));
plot(f3a,H3db)
axis([0,1000,-60,5])
title('Filtro de Chebyshev tipo II  (dB)')
grid

subplot(224)

%conversion a dBs
H4db = 20*log10(abs(H4));
plot(f4a,H4db)
axis([0,1000,-60,5])
title('Filtro elipitico (dB)')
grid
