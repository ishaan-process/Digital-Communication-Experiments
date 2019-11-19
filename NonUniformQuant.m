%Non-Unifrom Quantization
clc;
clear all;
close all;
u = 255;
v = audioread('TestFile.wav');
v = v';
x = max(v);
vcomp = ((x * log(1 + (abs(v)./x).*u))./log(1+u)).* sign(v);
[m,n] = size(vcomp);
d = n/10000;
for c = 1:d
    vcomp_new(c) = vcomp(10000*c);
    v_new(c) = v(10000*c);
end
prompt = ('How many Quantization Levels are required?');
levels = input(prompt);
ss = max((vcomp_new) - min(vcomp_new))/levels;
[m_new,n_new] = size(vcomp_new);
for e = 1:n_new
    start = min(vcomp_new);
    while(start < vcomp_new(e))
        start = start + ss;
    end
     vcomp_quant(e) = start - ss;
     if(start == vcomp_new(e));
         vcomp_quant(e) = start;
     end
end
for f = 1:n_new
    start = min(v_new);
    while(start < v_new(f))
        start = start + ss;
    end
     vnew_quant(f) = start - ss;
     
     if(start == v_new(f));
         vnew_quant(f) = start;
     end
end
S_new = (1/(2*n_new + 1)).*sum(vnew_quant.^2);
S_comp = (1/(2*n_new + 1)).*sum(vcomp_quant.^2);
subplot(2,2,1);
stem(v_new);
title('Original Sampled Signal');
subplot(2,2,2);
stem(vnew_quant);
title('Uniformy Quantized Singal');
subplot(2,2,3);
stem(vcomp_new);
title('Compressed Signal');
subplot(2,2,4);
stem(vcomp_quant);
title('Non-Uniform Sampled and Quantized Signal');
SNRU = 3*S_new*(2^(2*log2(levels)));
SNRNU = 3*S_comp*(2^(2*log2(levels)));