%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% pitch_related.m
% Generacion de una matriz que contiene la magnitud del espectro en el
% rango de 0-1kHz de los periodos de pitch candidatos de 20 a 147 muestras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pitch_related();
% Inicializacion de la matriz
% Cada columna representa un segmento que contendra un periodo de pitch
% candidato
p = zeros(160,128);
% Generacion de tren de impulsos con periodos de 20 a 147 muestras
for t = 20:147
    i = 0;
    n = 1;
    while n <= 160
        p(n,t-19) = 1;
        i = i+1;
        n = i*t+1;
    end
    p(:,t-19) = p(:,t-19)/i;
end
% FFT de 512-puntos de la matriz que contiene los segmentos
P = fft(p,512);
% Magnitud del espectro en el rango de 0-1kHz
magP = abs(P(1:65,:));
% Almacenamiento de la matriz de magnitud de espectio
save('C:\Documents and Settings\Paulo\Mis documentos\PROYECTO\SourceCode\matfiles\pitch_related','magP');