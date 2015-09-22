%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% s = trapz_window(s_m1,s_m); 
% Aplicacion ventana trapezoidal para interpolacion entre los segmentos de
% voz s_m1 y s_m 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s = trapz_window(s_m1,s_m);
% Ventana
ws = [-1*(0:79)/80+1,zeros(1,80)]';
% Senal final
s = ws.*s_m1(161:320)+(1-ws).*s_m(1:160);