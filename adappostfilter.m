%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% [postfilterSpeech sigma_1pf_last sigma_2pf_last] =
% adappostfilter(prevSpeech,actSpeech,actUV,actPitch,actLPC,sigma_1pf_past,
% sigma_2pf_past);
% Filtro adaptativo de post-procesamiento para un segmento de voz. Se
% requiere el segmento anterior prevSpeech, el segmento actual actSpeech,
% el indicador de sonido vocalico/no-vocalico UV, el periodo de pitch
% actPitch, los coefientes de prediccion lineal actLPC y los valores sigma
% de la muestra de voz anterior para el control adaptativo de ganancia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [postfilterSpeech sigma_1pf_last sigma_2pf_last] = adappostfilter(prevSpeech,actSpeech,actUV,actPitch,actLPC,sigma_1pf_past,sigma_2pf_past);
% Constantes del post-procesamiento
alpha_pf = 0.85;
beta_pf = 0.50;
mu_pf = 0.50;
gamma_pf = 0.50;
% g_pf = 0.00;
xi_pf = 0.99;
% Tamano del segmento
FL = 160;
% LTPF. Solo si el segmento de voz es vocalico
if actUV == 1
    x = actSpeech;
    % Senal retrasada
    y = [prevSpeech((FL-actPitch+1):FL);actSpeech(1:(FL-actPitch))];
    % Fortaleza de voz
    vs = xcorr(actSpeech,y,0)/xcorr(y,0);
    % Ganancia
    G_lpf = 1/(1+gamma_pf/vs);
    % Senal filtrada
    ltpfSpeech = filter(G_lpf*[1,zeros(1,actPitch-1),gamma_pf],1,actSpeech);
else
    ltpfSpeech = actSpeech;
end    
% STPF
stpfSpeech = filter((beta_pf.^[0:10]').*actLPC,(alpha_pf.^[0:10]').*actLPC,ltpfSpeech);
stpfSpeech = filter([1 -mu_pf],1,stpfSpeech);
% ACG
sigma_1pf(1) = xi_pf*sigma_1pf_past+(1-xi_pf)*abs(actSpeech(1));
sigma_2pf(1) = xi_pf*sigma_2pf_past+(1-xi_pf)*abs(stpfSpeech(1));
G_pf = sigma_1pf(1)/sigma_2pf(1);
postfilterSpeech(1) = G_pf*stpfSpeech(1);
for n = 2:FL
    sigma_1pf(n) = xi_pf*sigma_1pf(n-1)+(1-xi_pf)*abs(actSpeech(n));
    sigma_2pf(n) = xi_pf*sigma_2pf(n-1)+(1-xi_pf)*abs(stpfSpeech(n));
    G_pf = sigma_1pf(n)/sigma_2pf(n);
    postfilterSpeech(n) = G_pf*stpfSpeech(n);
end
% Envio de los valores sigma para el ACG del proximo segmento
sigma_1pf_last = sigma_1pf(160);
sigma_2pf_last = sigma_2pf(160);