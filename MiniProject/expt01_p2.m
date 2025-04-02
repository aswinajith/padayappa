clc;
close all;
clear all;
n_st=input('Enter the Starting Point of the Sequence; n = ');
x=input('Enter the Sequence: x(n) = ');
x_len=length(x);
n_ed=n_st+x_len-1;
n=n_st:n_ed;
figure (1);
subplot(3,1,1);
stem(n,x);
xlabel('Samples');
ylabel('Amplitude');
title('Time Shifting');

% Time Shifting (1st method)
k=input('Enter the shifting factor: k = ');
sh_sq01=n+k;
subplot(3,1,2);
stem(sh_sq01,x);
xlabel('Samples');
ylabel('Amplitude');

% Time Shifting (2nd method)
n1=min(n_st,n_st+k);
n2=max(n_ed,n_ed+k);
n_sh=n1:n2;
sh_sq02=[zeros(1,k) x zeros(1,-k)];
subplot(3,1,3);
stem(n_sh,sh_sq02);
xlabel('Samples');
ylabel('Amplitude');


% Time Scaling
a=input('Enter the scaling factor: a = ');
figure (2)
subplot(311);
stem(n,x);
xlabel('Samples');
ylabel('Amplitude');
if a > 1
    b=mod(n,a);
    c=[];
    d=[];
    for i=1:x_len
        if b(i)==0
            c=x(i);
            d=[d c];
        end
    end
    d;
    n_start=ceil(n_st/a);
    n_end=floor(n_ed/a);
    n_sc=n_start:n_end;
else
    e=(x_len/a)-(1/a)+1;
    d=[zeros(1,e)];
    d(1:1/a:end)=x;
    n_start=n_st/a;
    n_end=n_ed/a;
    n_sc=n_start:n_end;
end
subplot(312);
stem(n_sc,d);
xlabel('Samples');
ylabel('Amplitude');
title('Time Scaling');


% Time Reversal
x;
n;
nrev=-n;
x_rev=x(end:-1:1);
n_rev=nrev(end:-1:1);
subplot(313);
stem(n_rev,x_rev);
xlabel('Samples');
ylabel('Amplitude');
title('Time Reversal');

