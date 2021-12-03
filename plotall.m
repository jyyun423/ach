%% 

clear
clc
%% 

nn = 30000;
P = 0.019;
error = 0.1;
tx = 1;
rx = 1;
K = 0;
%% 

cd ./energy-per-bit;

g0 = ncx2inv(error,2*rx, 2*rx*K)/(2*K+2); %compute the error-th quantile of the sum of rx rician distributions with K-factor K
%
C_e = log2(1 + g0*P);% epsilon-capacity

rate_c = converse_simo(nn,P,error,rx,K);
rate_a1= ach_simo_nocsi(nn,P,error,rx,K);
rate_a = rate_a1;

plot(nn, C_e*ones(size(nn)), 'k-*');

hold on;
grid on;
plot(nn, rate_c,'r');
plot(nn,rate_a1,'b--');

legend(['Capacity = ',num2str(C_e)],'Converse','Achievability (no CSI)');

xlabel('Blocklen, n'); ylabel('Rate, bits/(ch. use)');
cd ..;