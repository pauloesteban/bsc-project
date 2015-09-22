%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% bandwidth_expansion.m
% Expansion del ancho de banda de los coeficientes de autocorrelacion
% 
% W_LAG = BANDWIDTH_EXPANSION() genera una ventana W_LAG para expandir
% el ancho de banda en 60 Hz. de los coeficientes de autocorrelacion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function w_lag = bandwidth_expansion();
% Numero de coeficientes de autocorrelacion
k = 10;
% Frecuencia de expansion
fo = 60;
% Ventana de expansion
w_lag = [1.001 exp(-0.5*(2*pi*fo*(1:k)/8000).^2)];
% El primer coeficiente de autocorrelacion R(0) se multiplicara por un
% factor de 1.001
% Los coeficientes R(1) a R(k) se multiplicaran por una funcion exponencial