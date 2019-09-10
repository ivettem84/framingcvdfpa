for k1=1:30
% Default parameters
% if nargin<1
%    para=[50 0.8];
% endj]=k\

n=[15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73];           % Population size, typically 10 to 25
p=[0.9 0.3 0.5 0.7 0.3 0.2 0.8 0.6 0.9 0.1 0.4 0.8 0.2 0.7 0.9 0.5 0.3 0.2 0.5 0.9 0.3 0.6 0.8 0.7 0.9 0.4 0.3 0.9 0.5 0.7];           % probabibility switch
% Iteration parameters
N_iter=[62 55 49 44 40 37 34 32 30 28 27 25 24 23 22 21 20 19 18 18 17 16 16 15 15 14 14 13 13 13];            % Total number of iterations

n=n(k1);
p=p(k1);
N_iter=N_iter(k1);

% s1=pwd; %Identify current folder
% s2=['\erroresFPA0804-' num2str(k1) '.txt'];
% %$s2='\erroresFPA0810.txt';
% dir = strcat(s1,s2);
% %--crear arhivo para guardar errores
% error1= fopen(dir, 'wt');

d=3;

% Lb=0*ones(1,d);
% Ub=30*ones(1,d);

Lb=[1 2 2];  
Ub=[2 30 30];

comienza=now;
tic;

[best,fmin,N_iter, bestnn, bestnnall]=fpann(n,p, Lb, Ub, N_iter,d )

tiempo = toc/60; 
tiempos = toc; 
arquitec(k1).nn = bestnn;
arquitec(k1).best = fmin;
arquitec(k1).capas = best;
arquitec(k1).tiempo = tiempo;
arquitec(k1).n= n;
arquitec(k1).p = p;
arquitec(k1).N_iter = N_iter;
arquitec(k1).bestnnall = bestnnall;
save('redescvdFPA1009.mat','arquitec');


termina=now;%%%%%%%%% TIEMPO FINAL
%fprintf(errord,['\n----------------------------------------\n\n']);
%fprintf(errord,['Best Solution:' num2str(bestX) ' fmin=',num2str(fMin) '   BSA time:', datestr(termina-comienza,'HH:MM:SS') '\n']);
disp(['Total number of evaluations: ',num2str(N_iter*n)]);
disp(['Best solution=',num2str(best),'   fmin=',num2str(fmin) '   FPA time:', datestr(termina-comienza,'HH:MM:SS')]);

%filename = [ 'nnBSA1409-' num2str(k1) ];
%save(filename)

end




