%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% [a b] = interdecim(p,a_cl,b_cl)
% Devuelve los vectores A y B de longitud variable y dependiente al periodo
% de pitch p, correspondientes a los coeficientes de Fourier a_cl y b_cl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a b] = interdecim_dec(p,a_cl,b_cl);
% Numero de armonicos
K = fix(p/2);
% Multiplo de 5 mas cercano
m = ceil(K/5);
% Tasas para interpolacion
M = [8 16 4 16 8 16 2 16 8 16 4 16 8 16];
% Tasas para decimacion
L = [1 3 1 5 3 7 1 9 5 11 3 13 7 15];
% Interpolacion/Decimacion del coeficiente a
a_int_1 = interp(a_cl,L(m-1));
a = decimate(a_int_1,M(m-1),17,'fir');
% Interpolacion/Decimacion del coeficiente b
b_int_1 = interp(b_cl,L(m-1));
b = decimate(b_int_1,M(m-1),17,'fir');