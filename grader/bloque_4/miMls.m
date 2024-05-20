function [err,w]=miLMS(d,x,Lw, mu)
% [err,w]=miLMS(d,x,Lw,mu);

% Parametros de entrada a la funcion son:
% - d: vector con las muestras de entrada de la senyal deseada.
% - x: vector con las muestras de entrada al filtro adaptativo.
% - Lw: numero de coeficientes del filtro adaptativo
% - mu: constante que controla la velocidad de convergencia.
%
% Parametros de salida:
% - err: vector que contiene las muestras de la senyal de error 
% - w: Matriz con N filas y Lw columnas (siendo N el tamano de las senales 
% de entrada). Cada columna representa un coeficiente y cada fila
% representa una iteracion.

%% Inicializacion
N=min([length(x),length(d)]); % Numero total de muestras de entrada

% Inicializa las variables de salida
err=zeros(N,1);

%Evolucion de los coeficientes en w. Tantas filas como muestras 
%y tantas columnas como numero de coeficientes
w=zeros(N,Lw);

%% Algoritmo LMS
%
% Inicializa para la primera iteracion
%
% xinput es la entrada del filtro adaptativo (cambia cada iteracion), contiene la
% muestra actual x[n] y las Lw-1 anteriores es decir:
% Lw = [x[n], x[n-1],... x[n-(Lw-1) ]]
% Los valores anteriores a la primera muestra de x son cero

xinput=zeros(Lw,1); % vector columna


% vector wn de los pesos en cada iteracion
wn=zeros(Lw,1); % pesos iniciales a cero, vector columna
%
%% Bucle iterativo
for n=1:N
    % Actualizacion de xinput para la iteracion n-esima
    xinput = [x(n); xinput(1:end-1)];
    
    % Algoritmo LMS
    % Paso 1: Obtiene la salida del filtro y[n] con los coeficientes wn y xinput
    y = wn.'*xinput;

    % Paso 2: Obtiene el valor del error e[n]
    err(n) = d(n) - y;

    % Paso 3: Actualiza los coeficientes del filtro wn para la siguiente iteracion
    wn = wn + 2*mu*err(n)*xinput;

    % Paso 4: Almacena los valores de los pesos actualizados en las filas de w
    w(n,:) = wn.';
end
