%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% main_STC.m
% Programa principal de la codificacion de parametros de la STC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Limpieza de variables y pantalla
clear all
clc
% Generacion de las magnitudes de espectro de los periodos de pitch
% candidatos
pitch_related;
% Inicializacion de memoria para el Analisis-Por-Sintesis
memVal = zeros(10,1);
% Carga de los diccionarios para la cuantizacion vectorial de las LSF
load('vq_LSF_1to4','CB_LSF_1to4')
load('vq_LSF_5to10','CB_LSF_5to10')
% Mensaje de bienvenida
disp('ESCUELA POLITECNICA DEL EJERCITO')
disp('DEPARTAMENTO DE ELECTRICA Y ELECTRONICA')
disp('PROYECTO DE GRADO - Paulo Esteban Chiliguano Torres')
disp('CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)')
% Ingreso del nombre del archivo de forma de onda (.wav)
filename = input('\nIngrese nombre de archivo (cadena de caracteres): ');
% Lectura de la senal de voz previamente grabada
[speech,fs,nbits] = wavread('a01');
% Buffering para la senal de entrada
sorig = buffer(speech,160,0);
% inicio = 13369;
% fin = 17296;
% speech = speech(inicio:fin);
% Mensaje de error y finalizacion de programa si la frecuencia de muestreo
% no es 8kHz
if fs ~= 8000
    disp('Archivo no valido. Frecuencia de muestreo diferente de 8kHz');
    return
end
% Mensaje de error y finalizacion de programa si el numero de bits de
% representacion es diferente de 16
if nbits ~= 16
    disp('Archivo no valido. Bits de representacion diferente de 16')
    return
end
% Borrado de variable innecesaria
clear nbits
% Periodo de simulacion
tFinal = length(speech)/fs;
% Borrado de variable innecesaria
clear fs
% Abre el modelo en SIMULINK
% open('encoder');
% Ejecuta el modelo de SIMULINK para el decodificador
sim('encoder_1',tFinal);
% Segmentacion de la senal ponderada en segmentos de 160 muestras
s_w = buffer(SignalWeighted,160,0);
% Segmentacion de la senal residual
r = buffer(residual,160,0);
% Codificacion y Decodificacion de parametros de excitacion
for j = 2:length(Pitch)
%     Seleccion de segmento prototipo
    seg_w = select_prototype(s_w(:,j),Pitch(j));
%     Analisis-Por-Sintesis del segmento prototipo
    [b,d,memVal,SNRAbS(j-1)] = AbyS(LPCWeighted(j-1,:),seg_w,memVal);
    clear seg_wj
%     Vectores de coeficientes de longitud constante
    [b_cl d_cl] = interdecim(b,d);
    clear b d
%     Conversion frecuencia-ERB
    [b_RMS,d_RMS,b_ERB,d_ERB] = freq2erb(b_cl,d_cl);
%     Cuantizacion escalar (SQ) de los coeficientes de Fourier
    [b_RMS,d_RMS,b_ERB,d_ERB] = stc_sq_quantiz(b_RMS,d_RMS,b_ERB,d_ERB);
%     Conversion ERB-frecuencia
    [b_cl_r d_cl_r] = erb2freq(b_RMS,d_RMS,b_ERB,d_ERB);
%     Recuperacion de los coeficientes
    [b d] = interdecim_dec(Pitch(j),b_cl_r,d_cl_r);
%     Reconstruccion senal residual
    r_m1(:,j-1) = recons_residual(Pitch(j),b,d,UV(j));
    r_dec(:,j-1) = r_m1(1:160,j-1);
%     SNR de cada segmento de la senal residual
    SNRres(j-1) = 10*log10(sum(r(:,j-1).^2)/sum((r_m1(1:160,j-1)-r(:,j-1)).^2));        
end
% Inicializacion ACG
sigma_1pf_past = 1;
sigma_2pf_past = 1;
for j = 2:length(Pitch)-1
%     Interpolacion entre segmentos con ventana trapezoidal
    ru(:,j) = trapz_window(r_m1(:,j-1),r_m1(:,j));
%     Conversion coeficientes LSF-LPC
    LPCs = lsf2poly(LSFs(j,:));
%     Sintesis de la senal
    s_u(:,j) = filter(1,LPCs,ru(:,j));
%     Filtro adaptativo de post-procesamiento
    [spp(:,j),sigma_1pf_past,sigma_2pf_past] = adappostfilter(s_u(:,j-1),s_u(:,j),UV(j+1),Pitch(j+1),LPCs',sigma_1pf_past,sigma_2pf_past);
%     Filtro de dispersion de pulso
    spdf(:,j) = pulsedispfilter(s_u(:,j));
%     SNR para segmento sintetico
    SNR1(:,j-1) = 10*log10(sum(sorig(:,j).^2)/sum((s_u(:,j)-sorig(:,j)).^2));
%     SNR para senal post-procesada
    SNR2(:,j-1) = 10*log10(sum(sorig(:,j).^2)/sum((spp(:,j)-sorig(:,j)).^2));
%     SNR para senal filtro de dispersion de pulso
    SNR3(:,j-1) = 10*log10(sum(sorig(:,j).^2)/sum((spdf(:,j)-sorig(:,j)).^2));
end
% Relacion SEGSNR
SEGSNRAbS = mean(SNRAbS);
SEGSNRres = mean(SNRres);
SEGSNRsynth = mean(SNR1);
SEGSNRpp = mean(SNR2);
SEGSNRpdf = mean(SNR3);
% Reconstruccion senal residual
residual_dec = reshape(r_dec,1,[]);
% Reconstruccion senal sintetica
speech1 = reshape(s_u,1,[]);
speech_synth = 0.98*speech1/(max(abs(speech1)));
% Reconstruccion senal post-procesamiento
speech2 = reshape(spp,1,[]);
speech_pp = 0.98*speech2/(max(abs(speech2)));
% Reconstruccion senal filtro dispersion pulso
speech3 = reshape(spdf,1,[]);
speech_pdf = 0.98*speech3/(max(abs(speech3)));
% Calculo Distancia Cepstral (CD)
sim('STC_Cepstral_Distance',tFinal);
CDresidual = mean(CD4(2:length(Pitch)));
CDsynth = mean(CD1(2:length(Pitch)));
CDpp = mean(CD2(2:length(Pitch)));
CDpdf = mean(CD3(2:length(Pitch)));
% Escuchar senal sintetica
pause
wavplay(speech1,8e3)
% Escuchar senal post-procesamiento
pause;
wavplay(speech2,8e3)
% Escuchar senal filtro dispersion pulso
pause;
wavplay(speech3,8e3)

subplot 211; plot(speech)
subplot 212; plot(synth1)

% wavwrite(synth1,8e3,'DA00')
% wavwrite(synth1,8e3,'signal10')
% Borrado de variables
clear memVal j SignalWeighted LPCWeighted CB_LSF_1to4
clear CB_LSF_5to10
clear CD1 CD2 CD3 CD4
clear LPCs
clear LSFs
clear SNRAbS SNRres SNR1 SNR2 SNR3
clear Weights
clear inicio fin
clear r r_dec r_m1 ru
clear s_u s_w
clear sigma_1pf_past sigma_2pf_past
clear sorig
clear spdf
clear spp
clear tFinal tout
clear UV

% figure(1)
% subplot 211
% plot(0:1/8000:(length(residual)-1)/8000,residual)
% subplot 212
% plot(0:1/8000:(length(residual_dec)-1)/8000,residual_dec)
% figure(2)
% subplot 121
% specgram(residual,512,8000,hamming(240))
% subplot 122
% specgram(residual_dec,512,8000,hamming(240))