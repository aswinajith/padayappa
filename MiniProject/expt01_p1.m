clc;
close all;
clear all; 
n1=input('Enter Starting Point n1: ');
n2=input('Enter End Point n2: ');
n=-n1:1:n2;

% Impulse Signal
amp_impl=[zeros(1,n1) 1 zeros(1,n2)];
figure(1);
subplot(221);
plot(n,amp_impl);
xlabel('Time');
ylabel('Amplitude');
title('Continious Impulse Signal');
subplot(222);
stem(n,amp_impl);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Impulse Signal');

% Step Signal
amp_stp=[zeros(1,n1) ones(1,n2+1)];
subplot(223);
stairs(n,amp_stp);
xlabel('Time');
ylabel('Amplitude');
title('Continious Step Signal');
subplot(224);
stem(n,amp_stp);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Step Signal');

% Ramp Signal
amp_rmp=[zeros(1,n1),n(n1+1:end)];
figure(2);
subplot(221);
plot(n,amp_rmp);
xlabel('Time');
ylabel('Amplitude');
title('Continious Ramp Signal');
subplot(222);
stem(n,amp_rmp);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Ramp Signal');

% Exponential Signal
n0=0:.1:n2;
Am_exp=input('Enter Amplitude of Exponential Wave Am: ');
b=input('Enter Decaying Factor of Exponential Wave b: ');
amp_expl=Am_exp*exp(-b.*n0);
figure(2);
subplot(223);
plot(n0,amp_expl);
xlabel('Time');
ylabel('Amplitude');
title('Continious Exponential Signal');
subplot(224);
stem(n0,amp_expl);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Exponential Signal');

% Sine Wave
 n=0:.02:1;
Am_sin=input('Enter Amplitude of Sine Wave Am: ');
f=input('Enter Frequency of Sine Wave f: ');
amp_sine=Am_sin*sin(2*pi*f*n);
figure(3)
subplot(221);
plot(n,amp_sine);
xlabel('Time');
ylabel('Amplitude');
title('Continious Sine Signal');
subplot(222);
stem(n,amp_sine);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Sine Signal');

% Square Wave
Am_sqre=input('Enter Amplitude of Square Wave Am: ');
f=input('Enter Frequency of Square Wave f: ');
dty=input('Enter Duty Cycle of Square Wave: ');
amp_sqre=Am_sqre*square(2*pi*f*n,dty);
subplot(223);
stairs(n,amp_sqre);
xlabel('Time');
ylabel('Amplitude');
title('Continious Square Signal');
subplot(224);
stem(n,amp_sqre);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Square Signal');

% Sawtooth Wave
Am_st=input('Enter Amplitude of Sawtooth Wave Am: ');
f=input('Enter Frequency of Sawtooth Wave f: ');
dty=input('Enter Duty Cycle of Sawtooth Wave: ');
amp_st=Am_st*sawtooth(2*pi*f*n,dty);
figure(4);
subplot(221);
plot(n,amp_st);
xlabel('Time');
ylabel('Amplitude');
title('Continious Sawtooth Signal');
subplot(222);
stem(n,amp_st);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Sawtooth Signal');


% Pulse Signal
n01=input('No. of zeros left to gate signal n01: ');
n11=input('No. of ones n11: ');
n02=input('No. of zeros right to gate signal n02: ');
n_sam=n01+n11+n02;
n=0:1:n_sam-1;
amp_gt=[zeros(1,n01) ones(1,n11) zeros(1,n02)];
subplot(223);
stairs(n,amp_gt);
xlabel('Time');
ylabel('Amplitude');
title('Continious Gate Signal');
subplot(224);
stem(n,amp_gt);
xlabel('Samples');
ylabel('Amplitude');
title('Discrete Gate Signal');
