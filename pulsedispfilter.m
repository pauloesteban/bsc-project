%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% filtSpeech = pulsedispfilter(postfiltSpeech)
% Accion de un filtro de dispersion de pulso sobre un segmento de voz
% postfiltSpeech
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function filtSpeech = pulsedispfilter(postfiltSpeech)
% Carga de los coeficientes del filtro
load('pulsedispfilt');
% Senal filtrada
filtSpeech = filter(tgp_coef,1,postfiltSpeech);