%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% pdcoeff.m
% Generacion de los coeficientes del filtro de dispersion de pulso
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pulso triangular
tgp = [(0:25)/25,(26:35)/-10+3.5,zeros(1,29)];

% Transformada de Fourier del pulso triangular
TGP = fft(tgp);

% Normalizacion de la Transformada de Fourier
TGP_coef = TGP./abs(TGP);

% Coeficientes del filtro
tgp_coef = ifft(TGP_coef);

% Almacenamiento de los coeficientes del filtro
save('C:\Documents and Settings\Paulo\Mis documentos\PROYECTO\SourceCode\matfiles\pulsedispfilt','tgp_coef');