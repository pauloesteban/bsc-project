%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% pitch_detection.m
% Deteccion del periodo de pitch de un segmento de voz
% 
% P = PITCH_DETECTION(MAGR) encuentra el periodo de pitch P en muestras de
% la magnitud del espectro MAGR del segmento de la senal residual de voz.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function P = pitch_detection(magR)
% Recuperacion de la matriz de magnitudes del espectro de los periodos de
% pitch candidatos
load('pitch_related')
% Busqueda del mejor periodo de pitch minimizando el error entre la
% magnitud del espectro de la senal residual y la magnitud del espectro del
% tren de impulsos con periodo de pitch candidato
for i = 1:128
    num = (sum(magP(:,i).*magR(1:65)))^2;
    den = sum(magP(:,i).^2);
    G(i) = num/den;
end
% Encuentra el indice con mayor ganancia que minimice el error entre las
% magnitudes de los espectros
[C I] = max(G);
% Mejor periodo de pitch en muestras
P = I+19;