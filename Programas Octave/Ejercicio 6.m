%% EJERCICIO 6
clear all
close all
clc
% Us´´(t) + (Us´(t)/RC) + (Us(t)/LC)=0
%Us´´(t)= - (Us´(t)/RC) - (Us(t)/LC)
S=load('audio.mat');
Ue=getfield(S,'sig');
h=getfield(S,'h');
R=2;
C=250*(10.^(-6));
L=0.1;
A=10;
a=0;
b=2.4414;    %b=(size(Ue)*h)+a
CIp=0;
CI=0;

Usppa=@(x,y0,y1) - (y1/(R*C)) - (y0/(L*C));


G=3;
[Us,Xn]=PI_Runge_Kutta_EDOG2_G_p(Usppa,Ue,h,a,b,CI,CIp,G);
subplot(2,1,1)
plot(Xn,Ue,'b');
hold on; grid on;
xlabel('X');ylabel('U_e');
legend('Función de entrada, U_e');
title('Entrada de audio');
subplot(2,1,2)
legend('Función de salida, U_S');
xlabel('X');ylabel('U_s');
sound(Us,1/h);