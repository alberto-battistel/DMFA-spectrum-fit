%% window fft

%l = 10e6+(1:10e6);
w = blackmanharris(length(A), 'periodic');

Afft = fft(w.*A)/length(A);
%Afft = fft(A)/Nsample;

clear A w