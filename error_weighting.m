%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% error_weighting.m
% Ponderacion de los Coeficientes de Prediccion Lineal
% A_W = ERROR_WEIGHTING(A,GAMMA) multiplica los coeficientes de prediccion
% lineal A(0),A(1),...,A(10) por un factor de ponderacion exponencial GAMMA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a_w = error_weighting(a,gamma);
for i = 1:length(a)
    a_w(i) = a(i).*gamma^(i-1);
end