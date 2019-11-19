clc;
clear all;
close all;
m=input('Enter the no. of message symbols : ');
z=[];
h=0; l=0;
for i=1:m
    fprintf('Ensemble %d\n',i);
    p(i)=input('');
end
p = sort(p,'descend');
a(1)=0;
for j=2:m;
    a(j)=a(j-1)+p(j-1);
end
fprintf('\n Alpha Matrix');
display(a);
for i=1:m
    n(i)= ceil(-1*(log2(p(i))));
end
fprintf('\n Code length matrix');
display(n);
for i=1:m
    int=a(i);
  for j=1:n(i)
    frac=int*2;
    c=floor(frac);
    frac=frac-c;
    z=[z c];
    int=frac;
  end
fprintf('Codeword %d',i);
display(z);
z=[];
end
fprintf('Avg. Code Length');
for i=1:m
    x=p(i)*n(i);
    l=l+x;
    x=p(i)*log2(1/p(i));
    h=h+x;
end
display(l);
fprintf('Entropy');
display(h);
fprintf('Efficiency');
display(100*h/l);
fprintf('Redundancy');
display(100-(100*h/l));