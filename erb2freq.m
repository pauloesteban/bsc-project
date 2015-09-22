%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% erb2freq.m
% Conversion de los coeficientes en escala ERB a coeficientes de Fourier en
% el dominio de la frecuencia
%
% [a_np b_np] = ERB2FREQ(a_RMS,b_RMS,a_ERB,b_ERB) hace la conversion de la
% escala ERB de los valores RMS y coeficientes normalizados a y b.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a b] = erb2freq(a_RMS,b_RMS,a_ERB,b_ERB);
% Frecuencia de muestreo
fs = 8000;
% Numero de bandas de la escala ERB
M = 10;
a_aux = a_RMS*a_ERB;
b_aux = b_RMS*b_ERB;
% Limite superior de la escala ERB
f_erb_up = 11.17*log((fs/2+312)/(fs/2+14675))+43;
% Limite inferior de la escala ERB
f_erb_low = f_erb_up/M;
% Interpolacion de la frecuencia
K = 80;
% Frecuencia fundamental
f0 = fs/160;
% Conversion ERB a frecuencia
f_erb = 11.17.*log((f0*(1:K)+312)./(f0*(1:K)+14675))+43;
% Asignacion de bandas
M_band = ceil(f_erb./f_erb_low);
% Asignacion en el dominio de la frecuencia
a = a_aux(M_band);
b = b_aux(M_band);