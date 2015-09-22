%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% freq2erb.m
% Conversion de los coeficientes de Fourier a escala ERB
%
% [A_RMS,B_RMS,A_AVRMS,B_AVRMS] = FREQ2ERB(A,B,P) hace la conversion
% de los pares de coeficientes de Fourier A y B, de un segmento prototipo
% con periodo de pitch P, del dominio de la frecuencia a 10 bandas de la
% escala ERB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a_RMS,b_RMS,a_ERB,b_ERB] = freq2erb(a,b);
% Numero de bandas de la escala
M = 10;
% Frecuencia de muestreo
fs = 8000;
% Valor RMS global para el coeficiente de Fourier A
a_RMS = norm(a)/sqrt(length(a));
% Valor RMS globar para el coeficiente de Fourier B
b_RMS = norm(b)/sqrt(length(a));
% Si los valores RMS son iguales a cero, se devuelve pares de coeficientes
% iguales a cero en la escala ERB
if a_RMS==0 && b_RMS==0
    a_ERB = zeros(10,1);
    b_ERB = zeros(10,1);
    return
end
% Numero de armonicos
K = 80;
% Frecuencia fundamental en Hz
f0 = fs/160;
% Conversion de la frecuencia fundamental y armonicos en escala ERB
f_erb = 11.17.*log((f0*(1:K)+312)./(f0*(1:K)+14675))+43;
% Limite superior de la escala ERB
f_erb_up = 11.17*log((fs/2+312)/(fs/2+14675))+43;
% Limite inferior de la escala ERB
f_erb_low = f_erb_up/M;
% Asignacion de las frecuencias transformadas a las M bandas en la escala
% ERB
M_band = ceil(f_erb./f_erb_low);
% Asignacion del valor promedio normalizado a cada una de las M bandas
for m = 1:M
    % Numero de coeficientes que pertenecen a la banda m
    indices = find(M_band==m);
    n = length(indices);
    
    if n == 0
        % Si no existen coeficientes en la banda i, el valor promedio
        % normalizado de cada coeficiente para la banda i es igual a 0
        a_ERB(m,1) = 0;
        b_ERB(m,1) = 0;
    else
        % Se encuentra los coeficientes A que pertenecen a la banda i
        a_values = a(indices);
        % Se asigna el promedio normalizado a la banda i
        a_ERB(m,1) = mean(a_values)./a_RMS;
        % Se encuentra los coeficientes B que pertenecen a la banda i
        b_values = b(indices);
        % Se asigna el promedio normalizado a la banda i
        b_ERB(m,1) = mean(b_values)./b_RMS;
    end
end