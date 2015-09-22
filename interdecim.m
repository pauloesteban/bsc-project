%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% [a_cl b_cl] = interdecim(a,b)
% Devuelve los vectores A_CL y B_CL de longitud constante para los vectores
% correspondientes a los coeficientes de Fourier A y B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a_cl b_cl] = interdecim(a,b);
% Multiplo de 5 mas cercano a la longitud de los vectores de entrada
m = ceil(length(a)/5);
% Relleno con ceros al final de los vectores
padsize = m*5-length(a);
aaux = padarray(a',padsize,0,'post');
baux = padarray(b',padsize,0,'post');
% Tasas de interpolacion
M = [8 16 4 16 8 16 2 16 8 16 4 16 8 16];
% Tasas de decimacion
L = [1 3 1 5 3 7 1 9 5 11 3 13 7 15];
% Interpolacion del coeficiente a
a_int = interp(aaux,M(m-1));
% Decimacion del coeficiente a
a_cl = decimate(a_int,L(m-1),17,'fir');
% a_int_1 = interp(a_dec,L(m-1));
% a_cl = decimate(a_int_1,M(m-1),17,'fir')
% Interpolacion del coeficiente b
b_int = interp(baux,M(m-1));
% Decimacion del coeficiente b
b_cl = decimate(b_int,L(m-1),17,'fir');
% b_int_1 = interp(b_dec,L(m-1));
% b_cl = decimate(b_int_1,M(m-1),17,'fir')