%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% hybrid_window.m
% Ventana Hibrida del pre-procesamiento de la senal de voz segun el
% estandar G.729
%
% WP = HYBRID_WINDOW() genera una ventana hibrida WP de 240 elementos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wp = hybrid_window();
% El primer intervalo corresponde a una ventana de Hammming
n = 0:199;
intervalo1 = 0.54 - 0.46*cos(2*pi*n/399);
% El segundo intervalo corresponde a una senal coseno
n = 200:239;
intervalo2 = cos(2*pi*(n-200)/159);
% La ventana final wp es la union de los dos intervalos anteriores
wp = [intervalo1 intervalo2];