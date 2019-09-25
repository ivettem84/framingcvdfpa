clc
clear all

for iteration= 1:1
tic;
comienza=now;
evaluacion=1;
    for j=1:30
        for k=0:30
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
            rreal=pac500targ(1,:);
            tn= rreal/100;
               % 2 capas
            if(k==0)%  1 capa
              net=newff(minmax(pn),[j,1],{'tansig','purelin','logsig'},'trainlm');                
            else    % 2 capas
              net=newff(minmax(pn),[j,k,1],{'tansig','tansig','purelin','purelin','logsig'},'trainlm');  
            end
           
            net.LW{2,1} = net.LW{2,1}*0.05;
            net.b{2}=net.b{2}*0.01;
            net.trainParam.show=NaN;
            net.trainParam.goal=1e-7;
            net.trainParam.lr=0.001;
            net.trainParam.epochs = 250;
            net.trainParam.showWindow=0;

            net = train(net,pn,tn);

            %Prueba
            load pac50trn.dat;
            load pac50tst.dat;
            x1=pac50trn;
            rtarg=pac50tst;
            rtarg1=pac50tst(1,:);

            
            sexo = x1(1,:);
            edad = x1(2,:)/100;
            sys= x1(3,:)/162;
            fuma=x1(4,:);
            diab=x1(5,:);
            imc= x1(6,:)/100;
            trata=x1(7,:);

            paciente=[sexo; edad; sys; fuma; diab; imc; trata];


            num=length(paciente);
            entr=sim(net,pn2);
            sim1 = entr*100;
%             riesgo1 = an2(1,:)*100;
%             edadcar = an2(2,:)*100;

%             riesgo =round(riesgo1,1);
%             edadcar = round(edadcar);

            %sim1 = [riesgo1;edadcar];

            MSE= mymse(rtarg1,sim1);

            o = MSE;
            red = net;
           
            arquitectura(evaluacion).L1 =j;
            arquitectura(evaluacion).L2 =k;
            arquitectura(evaluacion).error =o;
            arquitectura(evaluacion).red =red;
            evaluacion=evaluacion+1
   
            
            
           
        end
    end
     termina=now;
     tiempo = toc/60; 
     tiempos = toc; 
     dumb=iteration
     arquitec(iteration).iteration = iteration;
     arquitec(iteration).arquitectura = arquitectura;  
     arquitec(iteration).tiempo = tiempo;
     arquitec(iteration).hora1=datestr(termina-comienza,'HH:MM:SS');
     save('redsimplemod1.mat','arquitec');
end