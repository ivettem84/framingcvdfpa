clc;
clear;

load pacicvdtrn.dat
load pacicvdtarg.dat

p=pacicvdtrn;
t=pacicvdtarg;

net=newff(minmax(p), [12,2], {'tansig','purelin','purelin'},'trainlm'); 
net.LW{1,1}=net.LW{1,1}*0.01;       %Pesos de conexiones
net.b{1}=net.b{1}*0.01;             %Umbrales
net.trainParam.show = 100;           % El resultado se muestra cada 100 épocas
net.trainParam.lr = 0.02;           % Tasa de aprendizaje usado en algún gradiente
net.trainParam.epochs =1000;         % Máximo numero de iteraciones
net.trainParam.goal = 1e-5;          % Tolerancia de Error, criterio de parada
net.trainParam.min_grad=1e-11;         %Minimum performance gradient
%Start training
net.trainParam.showWindow=0;
[net,tr1] = train(net,p, t);


y = net(p);
e = gsubtract(t,y);
performance = perform(net,t,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulando datos entrenados
A1=sim(net,p);
%Riesgo=round(A1*100);


%save('framin130201.mat')