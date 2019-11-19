%Performance of uniform quantization
%Rajat Sindhu
clc;
clear all;
close all;
x = linspace(-5,5);                                    
y = (1/sqrt(2*pi)) * exp(-(x.^2)/2);
prompt = 'Enter Sampling Frequency Fs: ';
fs = input(prompt);
prompt2 = 'Enter number of quantization levels: ';
q = input(prompt2);
int = 1/fs;
xalt = -5:int:5;
ysampled = (1/sqrt(2*pi)) * exp(-(xalt.^2)/2);
[m n] = size(ysampled);
%Finding quantization error and assigning digital levels
ss = (max(y) - min(y))/q;  %step size
ydig = [];
for d = 1:n
  for e = (min(y)+ss):ss:max(y)
    if (ysampled(d) >= e - ss)
      ydig(d) = e;
    else
      ydig(d) = e - ss;
      break;
    end
  end
end
t = max(y)/ss;
a = 0:q;
s1 = linspace(0,floor(t));
s2 = floor(s1) + 1/2;
subplot(2,2,1);
plot(x,y);     
title("Original Gaussian Signal and its Sampled Variant");              %plots Gaussian function
hold on;
stem(xalt,ysampled);         %sampled signal
hold off;
subplot(1,2,2);
stem(xalt,ydig);
title("Sampled and Quantized Variant of original signal");              
yticks(min(y):ss:max(y));
yticklabels(0:q); 

            