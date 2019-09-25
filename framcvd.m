clc;
clear;

load pac500train.dat;
load pac500targ.dat;
warning off
p= pac500train;
sexo = p(1,:);
edad = p(2,:)/100;
sys= p(3,:)/162;
fuma=p(4,:);
diab=p(5,:);
imc= p(6,:)/100;
trata=p(7,:);

pn =[sexo; edad; sys; fuma; diab; imc; trata];
tn= pac500targ/100;

net=newff(minmax(pn), [17,3,2], {'tansig','tansig','purelin','purelin','logsig','logsig'},'trainlm'); 
net.LW{1,1}=net.LW{1,1}*0.01;       %Pesos de conexiones
net.b{1}=net.b{1}*0.01;             %Umbrales
net.trainParam.show = 100;           % El resultado se muestra cada 100 épocas
net.trainParam.lr = 0.02;           % Tasa de aprendizaje usado en algún gradiente
net.trainParam.epochs =1000;         % Máximo numero de iteraciones
net.trainParam.goal = 1e-7;          % Tolerancia de Error, criterio de parada
net.trainParam.min_grad=1e-11;         %Minimum performance gradient
%Start training
%net.trainParam.showWindow=0;
[net,tr1] = train(net,pn, tn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulando datos entrenados
A1=sim(net,pn);
Riesgo=round(A1*100);

MSE= mymse(A1,tn);

%mse_calc = sum((A1-t).^2)/length(t);

save('framin170919.mat')