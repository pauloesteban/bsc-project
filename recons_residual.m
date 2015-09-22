%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% r_np = recons_residual(p_np,a_np,b_np,UV)
% Reconstruye la senal residual r_np a partir del periodo de pitch y las
% amplitudes y fases de sus armonicos, implicitos en los coeficientes de
% Fourier a_np y b_np. La decision vocalico/no-vocalico UV se usa para el
% calculo de las fases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function r_np = recons_residual(p_np,a_np,b_np,uv);
% C = a_np-i*b_np;
% c = ifft(C,512,'symmetric');
% r_np = resample(c,p_np,512);
% Calculo de la amplitud
A = sqrt(a_np.^2+b_np.^2);
% Calculo de la fase
if uv == 1
    pha = -atan2(b_np,a_np);
else
    % Si el segmento es no-vocalico las fases son distribuidas
    % uniformemente en el rango de -pi a +pi
    pha = -pi + (2*pi) * rand(1,p_np);
end
% Reconstruccion de la senal en base a las amplitudes y fases de los
% armonicos
n = 0:319;
r_np = zeros(320,1);
K = fix(p_np/2);
for k = 1:K
    r_np = A(k)*cos(k*n'*2*pi/p_np+pha(k))+r_np;
end