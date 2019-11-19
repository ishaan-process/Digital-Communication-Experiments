clc;
clear all;
close all;
data=[0 1 0 1 1 1 0 0 1 1];

figure(1)
stem(data, 'linewidth',3), grid on;
title('  Information before Transmiting ');
axis([ 0 11 0 1.5]);

data_NZR=2*data-1;
s_p_data=reshape(data_NZR,2,length(data)/2); 

f=10.^6;
T=1/f;
t=T/99:T/99:T;

y=[];
y_in=[];
y_qd=[];

for(i=1:length(data)/2)
    y1=s_p_data(1,i)*cos(2*pi*f*t); 
    y2=s_p_data(2,i)*sin(2*pi*f*t) ;
    y_in=[y_in y1]; 
    y_qd=[y_qd y2]; 
    y=[y y1+y2]; 
end

Tx_sig=y;
tt=T/99:T/99:(T*length(data))/2;


figure(2)

subplot(3,1,1);
plot(tt,y_in,'linewidth',3), grid on;
title(' wave form for inphase component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt)');

subplot(3,1,2);
plot(tt,y_qd,'linewidth',3), grid on;
title(' wave form for Quadrature component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt)');


subplot(3,1,3);
plot(tt,Tx_sig,'r','linewidth',3), grid on;
title('QPSK modulated signal (sum of inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel(' amplitude(volt)');
