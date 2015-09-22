%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% AbyS.m
% Determinacion de los coeficientes de Fourier con la tecnica de
% Analisis-por-Sintesis (AbS)
%
% [A,B,ACTUALMEM,SEGSNR] = ABYS(A_W,SEG_W,VIRTUALMEM) calcula los
% coeficiente de Fourier A y B de un segmento prototipo SEG_W, y devuelve
% los valores de memoria ACTUALMEM del filtro que sera usada en el
% Analisis-por-Sintesis (AbS) del proximo segmento prototipo
%
% A_W, son los Coeficientes de Prediccion Lineal del filtro LPC ponderado,
% relacionados al segmento SEG_W
% 
% VIRTUALMEM son los valores de memoria para el filtro LPC ponderado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a,b,aMem,SEGSNR] = AbyS(a_w,seg_w,vMem)
% Periodo de pitch del segmento, igual a la longitud del segmento prototipo
P = length(seg_w);
% Memoria actual
vMem = flipud(vMem);
for n = 1:P
    m(n,1) = sum(-a_w(2:11)'.*vMem);
    vMem(2:10) = vMem(1:9);
    vMem(1) = m(n,1);
end
% Senal de error inicial
% stem(m);pause
e = seg_w-m;
% e = seg_w;

% Error cuadratico medio (MSE)
MSE(1) = sum(e.^2);
% Respuesta impulsiva del filtro de sintesis LPC ponderado
[h,t] = impz(1,a_w,P);
n = [0:P-1]';
% DFT de P-puntos de la respuesta impulsiva
H = fft(h,P);
% Variable auxiliar gamma_11
gamma_11 = P/2*(real(H)).^2+P/2*(imag(H)).^2;
% Frecuencia fundamental en radianes
w0 = 2*pi/P;
% Numero de iteraciones
K = fix(P/2);

for k = 1:K    
    % DFT de P-puntos del error
    E = fft(e,P);    
    % Variables auxiliares
    i = k+1;
    psi_1 = real(E(i)).*real(H(i))+imag(E(i)).*imag(H(i));
    psi_2 = real(E(i)).*imag(H(i))-imag(E(i)).*real(H(i));
    % Coeficientes de Fourier para la k-esima onda sinusoidal
    a(k) = psi_1/gamma_11(i);
    b(k) = psi_2/gamma_11(i);   
    % Amplitud de la k-esima onda sinusoidal
    A = sqrt(a(k)^2+b(k)^2);
    % Fase de la k-esima onda sinusoidal
    pha = -atan2(b(k),a(k));
    % Actualizacion de la senal de error
    e = e-filter(1,a_w,A*cos(n*k*w0+pha));
    % MSE para el k-esimo armonico
    MSE(i) = sum(e.^2);
end

% Busqueda del menor MSE (MMSE)
[MMSE,K1] = min(MSE);
if K1 == 1
    a = zeros(1,K);
    b = zeros(1,K);
else
    aux_a = zeros(1,K);
    aux_b = zeros(1,K);
    for k = 1:K1-1
        aux_a(k) = a(k);
        aux_b(k) = b(k);
    end
    a = aux_a;
    b = aux_b;
end

r = zeros(P,1);
for k = 1:K1-1
    A = sqrt(a(k)^2+b(k)^2);
    pha = -atan2(b(k),a(k));
    r = r+A*cos(n*k*w0+pha);
end
seg_synth = filter(1,a_w,r);
if sum((seg_synth-seg_w).^2) == 0
    SEGSNR = 0;
else
    SEGSNR = 10*log10(sum(seg_w.^2)/sum((seg_synth-seg_w).^2));
end
% Memoria virtual para el proximo segmento prototipo
p = length(a_w)-1;
aMem = seg_w(P-p+1:P);

% figure(1)
% clf
% % Grafica del segmento prototipo original
% subplot 211
% plot(0:P-1,seg_w)
% title('Segmento prototipo original')
% xlabel('Muestras')
% ylabel('Amplitud')
% % Grafica segmento prototipo sintetizado
% subplot 212
% plot(0:P-1,seg_synth)
% text(1,max(abs(seg_synth)),['SEGSNR=',num2str(SEGSNR),'dB'],'VerticalAlignment','top','Color','k','FontWeight','bold','EdgeColor','k');
% title('Segmento prototipo sintetizado')
% xlabel('Muestras')
% ylabel('Amplitud')
% % Grafica del MSE del modelamiento
% figure(2)
% clf
% plot(0:K,MSE,':.')
% title('Error Cuadratico Medio')
% xlabel('Iteraccion/No.Armonicos')
% ylabel('MSE')
% % Grafica del MMSE
% hold on
% plot(K1-1,MMSE,'o','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
% pause