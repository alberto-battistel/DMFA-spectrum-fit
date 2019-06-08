%% window fft

l = 10e6+(1:9e6);
%w = blackmanharris(length(A), 'periodic');

%Afft = fft(w.*A)/length(A);
Bfft = fft(B(l))/length(l);

clear B