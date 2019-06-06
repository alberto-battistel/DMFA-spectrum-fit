% Load data and cut what you need

clear

load('Redox_MultiACL00_4dec_quasiCV2_10mV.mat')

l = 625000+(1:5e6);
L = length(l);

%w = blackmanharris(L,'periodic');
w = hamming(L, 'periodic');
y = fftshift(fft(v(l))/L);


tmax = Tinterval*L;
f = f0;