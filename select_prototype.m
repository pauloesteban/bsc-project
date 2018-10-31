function seg_w = select_prototype(s_w,P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESCUELA POLITECNICA DEL EJERCITO
% DEPARTAMENTO DE ELECTRICA Y ELECTRONICA
% PROYECTO DE GRADO
% CODIFICADOR POR TRANSFORMADA SINUSOIDAL (STC)
% Paulo Esteban Chiliguano Torres
%
% select_prototype.m
% Seleccion de segmento prototipo
% SEG_W = SELECT_PROTOTYPE(S_W,P) selecciona un segmento prototipo SEG_W de
% P muestras de un segmento S_W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Longitud del segmento de voz
FL = length(s_w);
% Limites de la porcion central del segmento
a = FL/2+1-round(P/2);
b = P+a-1;
% Maxima amplitud dentro de la porcion central
[C I] = max(s_w(a:b));
max_s_w = I+a-1;
% Limites para el segmento prototipo
if max_s_w+P-1 <= FL
    a = max_s_w;
    b = a+P-1;
end
% Inicio del segmento prototipo en un cruce por cero
for j = a:-1:2
    if s_w(j)>0 && s_w(j-1)<=0
        if abs(s_w(j)) < abs(s_w(j-1))
            a = j;
        elseif abs(s_w(j-1)) < abs(s_w(j))
            a = j-1;
        end
        b = a+P-1;
        break;
    end
end
% Segmento prototipo final
seg_w = s_w(a:b);
end

% % Grafica segmento prototipo
% figure(1)
% clf
% plot([a:b],seg_w,'k','LineWidth',2)
% hold on;
% plot(1:FL,s_w,'k:')
% xlabel('Muestras')
% ylabel('Amplitud')
% title('Seleccion de segmento prototipo')
% text(a,0,['Inicio \rightarrow'],'HorizontalAlignment','right','Color','k','FontWeight','bold');
% text(b,0,['\leftarrow Fin'],'Color','k','FontWeight','bold');
% pause;