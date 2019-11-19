%QPSK Simulation
%Digital Communication, Rajat Sindhu
clc;
clear all;
close all;
syms t
prompt1 = 'Enter length of bit stream L : ';
prompt2 = 'Enter bit energy \E_b : ';
prompt3 = 'Enter bit duration \tau : '; 
prompt4 = 'Enter frequency of modulant signal \f_c : ';
L = input(prompt1); Eb = input(prompt2); tau = input(prompt3); fc = input(prompt4); 
Fi_1 = piecewise(0<=t<=tau,sqrt(2/tau)*cos(2*pi*fc*t),0);
Fi_2 = piecewise(0<=t<=tau,-sqrt(2/tau)*sin(2*pi*fc*t),0);
Bit_Stream = randi(2,[1 L]);
%Bit_Stream = [2 2 1 1 2 1 1 1 2 1];
Inphase_BPSK = symfun(0,t);
Quadrature_BPSK = symfun(0,t);
for N = 1:L
    if(Bit_Stream(N) == 2)
        Bit_Stream(N) = 1;
    else
        Bit_Stream(N) = -1;
    end 
end
add1 = Fi_1; add2 = Fi_2;
for P = 1:2:(L - 1)
    if(Bit_Stream(P) == 1)
        Inphase_BPSK(t) = Inphase_BPSK + sqrt(Eb)*add1;
    else 
        Inphase_BPSK(t) = Inphase_BPSK - sqrt(Eb)*add1;
    end
    
    if(Bit_Stream(P+1) == 1)
        Quadrature_BPSK = Quadrature_BPSK - sqrt(Eb)*add2;
    else
        Quadrature_BPSK = Quadrature_BPSK + sqrt(Eb)*add2;
    end
    add1(t) = subs(add1,t-tau); 
    add2(t) = subs(add2,t-tau);
end
QPSK_Final = Inphase_BPSK + Quadrature_BPSK;
subplot(5,1,1);
stem(Bit_Stream,'filled');
title('Level-Shifted Bit Stream');
subplot(5,1,2);
fplot(Inphase_BPSK,[0 L*tau/2],'linewidth',3,'color','w');
ax1 = gca;
set(gca,'color','k');
title('Inphase BPSK Signal');
subplot(5,1,3);
fplot(Quadrature_BPSK,[0 L*tau/2],'linewidth',3,'color','b');
ax2 = gca;
grid on;
title('Quadrature BPSK Signal');
subplot(5,1,4);
fplot(QPSK_Final,[0 L*tau/2],'linewidth',3,'color','r');
set([gca,ax1,ax2],'xtick',[0:L/2]);
grid on;
title('QPSK Signal');
%We generated the signal QPSK hence
%Proceeding to Reception
%Let the sampling instant be tau
count = 0;
dibit = [];
for Q = 1:L/2
    rng('shuffle');
    rv1(Q) = double(int(QPSK_Final*subs(Fi_1,t - count*tau),t,count*tau,(count+1)*tau)) + randn;
    rng('shuffle');
    rv2(Q) = double(int(-QPSK_Final*subs(Fi_2,t - count*tau),t,count*tau,(count+1)*tau)) + randn;
    if(rv1(Q) > 0) 
        if(rv2(Q) > 0)
            dibit = [dibit [1 1]];
        else
            dibit = [dibit [1 -1]];
        end 
    else
        if(rv2(Q) > 0) 
            dibit = [dibit [-1 1]];
        else 
            dibit = [dibit [-1 -1]];
        end 
    end
    count = count + 1;
end
formatspec = 'Recieved bit-stream for Eb = %d and Probability error = %d';
str = sprintf(formatspec,Eb,erfc(sqrt(Eb)/2));
subplot(5,1,5)       
stem(dibit,'filled');
title(str);