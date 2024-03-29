function [iL]=mediciones_iL(t,pvl,ccms)

% t= vector de instantes de tiempo de medición [s]
% pvl= Porcentaje de valor de lectura. Incertidumbre de tipo i.i.d.
% gaussiano que asegura valores comprendidos en un rango con 95% de
% seguridad.
% ccms= Cantidad de veces la cifra menos significativa. Incertidumbre de
% tipo i.i.d. gaussiano que asegura valores comprendidos en un rango con
% 95% de seguridad.
% us= Mediciones de tensión sobre el resistor del circuito [V]



if (min(t)>=0 && max(t)<=1)
    L=0.1; A=10; R=2; C=250*10^(-6);
    b1=1 / (R*C);
    c1=1 / (L*C);
    s1=(-b1+(b1^(2)-4*c1)^(1/2))/2; %polo 1
    s2=(-b1-(b1^(2)-4*c1)^(1/2))/2; %polo 2
    
    K1 = A / (s1-s2);
    K2 = A / (s2-s1);
    
    iL= 1/L* (K1 * exp (s1 * t) + K2 * exp (s2 * t) ) .* (t>=0); %solucion analitica
    
    %Seteo automático del fondo de escala del voltímetro de 3 1/2
    FS=1999;    
    digitos=[4 0];
    while abs(max(iL))<FS/10 || abs(max(iL))>FS
        if abs(max(iL))<FS/10
                FS=FS/10;
                digitos(1)=digitos(1)-1; digitos(2)=digitos(2)+1;
        elseif abs(max(iL))>FS
                FS=FS*10;
                digitos(1)=digitos(1)+1; digitos(2)=digitos(2)-1;
        end
    end 
    
    e_ccms= (ccms * (1*10^(-digitos(2))) /2) * ( randn(1,length(t)));
    e_pvl = (pvl/100 * iL /2) .* ( randn(1,length(t)));
    iL= iL + e_pvl + e_ccms; %solucion analitica + ruido
    
    iL=min(iL,FS);
    iL=sprintf(['% ' num2str(digitos(1)) '.' num2str(digitos(2)) 'f\n'],iL);
    iL=str2num(iL);

else


    display('Error: Los instantes de medición deben estar comprendidos entre 0s y 1s');
    
end
plot(t,iL.','o')

