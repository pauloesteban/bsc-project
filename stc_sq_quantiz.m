%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% stc_sq_cuantiz.m
% Programa para la cuantizacion escalar (SQ) de los coeficientes de Fourier
%
% [b_RMSq d_RMSq b_ERBq d_ERBq]=STC_SQ_QUANTIZ(b_RMS,d_RMS,b_ERB,d_ERB)
% devuelve los valores cuantizados (d_RMSq y d_RMSq) para los valores RMS
% de los coeficientes de Fourier (b_RMS y d_RMS) y los valores cuantizados
% (b_ERBq y d_ERBq) de los coeficientes de Fourier normalizados en la
% escala ERB (b_ERB y d_ERB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [b_RMSq d_RMSq b_ERBq d_ERBq] = stc_sq_quantiz(b_RMS,d_RMS,b_ERB,d_ERB)
% Carga del diccionario y limites de particion para el valor RMS del
% coeficiente B
load('sq_b_RMS','CB_b_RMS','BP_b_RMS')
% Cuantizacion del valor RMS del coeficiente B
[index,b_RMSq] = quantiz(b_RMS,BP_b_RMS,CB_b_RMS);
% Carga del diccionario y limites de particion para el valor RMS del
% coeficiente D
load('sq_d_RMS','CB_d_RMS','BP_d_RMS')
% Cuantizacion del valor RMS del coeficiente D
[index,d_RMSq] = quantiz(d_RMS,BP_d_RMS,CB_d_RMS);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=1 de la escala ERB
load('sq_b_1','CB_b_1','BP_b_1')
load('sq_d_1','CB_d_1','BP_d_1')
% Cuantización del coeficiente B normalizado en la banda M=1
[index,b_ERBq(1,:)] = quantiz(b_ERB(1,:),BP_b_1,CB_b_1);
[index,d_ERBq(1,:)] = quantiz(d_ERB(1,:),BP_d_1,CB_d_1);

% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=2 de la escala ERB
load('sq_b_2','CB_b_2','BP_b_2')
load('sq_d_2','CB_d_2','BP_d_2')
% Cuantización del coeficiente B normalizado en la banda M=2
[index,b_ERBq(2,:)] = quantiz(b_ERB(2,:),BP_b_2,CB_b_2);
[index,d_ERBq(2,:)] = quantiz(d_ERB(2,:),BP_d_2,CB_d_2);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=3 de la escala ERB
load('sq_b_3','CB_b_3','BP_b_3')
load('sq_d_3','CB_d_3','BP_d_3')
% Cuantización del coeficiente B normalizado en la banda M=3
[index,b_ERBq(3,:)] = quantiz(b_ERB(3,:),BP_b_3,CB_b_3);
[index,d_ERBq(3,:)] = quantiz(d_ERB(3,:),BP_d_3,CB_d_3);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=4 de la escala ERB
load('sq_b_4','CB_b_4','BP_b_4')
load('sq_d_4','CB_d_4','BP_d_4')
% Cuantización del coeficiente B normalizado en la banda M=4
[index,b_ERBq(4,:)] = quantiz(b_ERB(4,:),BP_b_4,CB_b_4);
[index,d_ERBq(4,:)] = quantiz(d_ERB(4,:),BP_d_4,CB_d_4);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=5 de la escala ERB
load('sq_b_5','CB_b_5','BP_b_5')
load('sq_d_5','CB_d_5','BP_d_5')
% Cuantización del coeficiente B normalizado en la banda M=5
[index,b_ERBq(5,:)] = quantiz(b_ERB(5,:),BP_b_5,CB_b_5);
[index,d_ERBq(5,:)] = quantiz(d_ERB(5,:),BP_d_5,CB_d_5);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=6 de la escala ERB
load('sq_b_6','CB_b_6','BP_b_6')
load('sq_d_6','CB_d_6','BP_d_6')
% Cuantización del coeficiente B normalizado en la banda M=6
[index,b_ERBq(6,:)] = quantiz(b_ERB(6,:),BP_b_6,CB_b_6);
[index,d_ERBq(6,:)] = quantiz(d_ERB(6,:),BP_d_6,CB_d_6);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=7 de la escala ERB
load('sq_b_7','CB_b_7','BP_b_7')
load('sq_d_7','CB_d_7','BP_d_7')
% Cuantización del coeficiente B normalizado en la banda M=7
[index,b_ERBq(7,:)] = quantiz(b_ERB(7,:),BP_b_7,CB_b_7);
[index,d_ERBq(7,:)] = quantiz(d_ERB(7,:),BP_d_7,CB_d_7);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=8 de la escala ERB
load('sq_b_8','CB_b_8','BP_b_8')
load('sq_d_8','CB_d_8','BP_d_8')
% Cuantización del coeficiente B normalizado en la banda M=8
[index,b_ERBq(8,:)] = quantiz(b_ERB(8,:),BP_b_8,CB_b_8);
[index,d_ERBq(8,:)] = quantiz(d_ERB(8,:),BP_d_8,CB_d_8);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=9 de la escala ERB
load('sq_b_9','CB_b_9','BP_b_9')
load('sq_d_9','CB_d_9','BP_d_9')
% Cuantización del coeficiente B normalizado en la banda M=9
[index,b_ERBq(9,:)] = quantiz(b_ERB(9,:),BP_b_9,CB_b_9);
[index,d_ERBq(9,:)] = quantiz(d_ERB(9,:),BP_d_9,CB_d_9);
% Carga del diccionario y limites de particion para el coeficientes B y D
% normalizados en la banda M=10 de la escala ERB
load('sq_b_10','CB_b_10','BP_b_10')
load('sq_d_10','CB_d_10','BP_d_10')
% Cuantización del coeficiente B normalizado en la banda M=10
[index,b_ERBq(10,:)] = quantiz(b_ERB(10,:),BP_b_10,CB_b_10);
[index,d_ERBq(10,:)] = quantiz(d_ERB(10,:),BP_d_10,CB_d_10);