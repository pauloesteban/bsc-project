%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% vu_decision.m
% Decision Vocalica/No-Vocalica
% 
% V = VU_DECISION(S) devuelve V=1 si el segmento de senal de voz S es
% vocalico o V=0 si el segmento es no-vocalico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v = vu_decision(s);
% Coeficientes del filtro pasa-bajo h[n]
% h = [0.125 0.375 0.375 0.125];
% Coeficientes del filtro pasa-alto g[n]
% g = [0 -2 2 0];
% Modo de extension periodico para la Transformada Discreta Wavelet (DWT)
% para disminuir el efecto de las discontinuidades entre segmentos de senal
% de voz
dwtmode('ppd','nodisp');
% Escala maxima de la DWT
N = 1;
% Descomposicion del segmento
[C,L] = wavedec(s,N,'bior3.1');
% Reconstruccion de la senal de detalle
D1 = wrcoef('d',C,L,'bior3.1',1);
% Reconstruccion de la senal de aproximacion
A1 = wrcoef('a',C,L,'bior3.1',1);
% Umbral - Relacion entre el valor RMS de la senal de detalle D1 y el valor
% RMS de la senal de aproximacion A1
sRMS = (norm(s)/length(s));
if sRMS<-49
    % El segmento es clasificado como silencio
    v = 2;
    return
end

if norm(A1)~=0
    r_th = norm(D1)/norm(A1);
else
    r_th = 0;
end

% Decision U/V en base al valor del umbral
if r_th > 2
    % Si el umbral es mayor a 2 el segmento es no-vocalico (U)
    v = 0;
else
    % Caso contrario el segmento es vocalico (V)
    v = 1;
end

% sv = 10*log10(norm(s)/sqrt(length(s)));
% if sv < 100
%     v=0;
% end