%% window fft

l = 10e6+(1:10e6);
w = blackmanharris(length(l), 'periodic');

Afft = fft(w.*A(l))/length(l);
%Afft = fft(A)/Nsample;

clear A w