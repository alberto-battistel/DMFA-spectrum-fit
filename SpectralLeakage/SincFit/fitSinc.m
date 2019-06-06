%% fit sinc
% the signal to fit has a frequency f different from the expected f0 of a
% df which should be small.
% df is found through a fitting of a frequency shifted cos. Windowing
% helps a lot. Precision in determining the frequency shift is proportional
% to the signal to ratio. With 100 order of magnitude clearance one has 10
% % error in the frequency shift.

%% synthetic data
f0 = 10000;
df = 0.01;

Tinterval = 2e-6;
tmax = 10;
L = tmax/Tinterval;

t = (0:L-1).'/L*tmax;

noise = 1e-2.*randn(L,1);
s = 0.001*cos(2*pi*(f0+df)*t+1) + noise;

%% Real data from the potential
% % use loadData
% 
% f0 = 104;
% s = v(l);


%% Fitting
% window
w = hamming(L, 'periodic');
y = fft(w.*s)/L;

% no window
%y = fft(w.*s)/L;

% number of points to fit in the FFT
np = 100;
% vector to center FFT
lf = floor((f0*tmax)+(-np/2:np/2-1)+1);

% window
w = hamming(np, 'periodic');
yf = @(V) V(1)*fftshift(fft(w.*exp(1j*2*pi*V(2)*(0:np-1)/np).')/np);

% % no window
% %yf = @(V) V(1)*fftshift(fft(exp(1j*2*pi*V(2)*(0:np-1)/np).')/np);
% 
% % chi2 based on Abs
% chi2 = @(V) sum((abs(y(lf)) - abs(yf(V))).^2);
% 
% options = optimoptions(@fminunc,'display','iter','TolFun', 1e-10, 'TolX', 1e-10);
% 
% % first guess from position and intensity of FFT
% [V0(1), V0(2)] = max(abs(y(lf)));
% V0(2) = V0(2)-np/2-1;   % shift
% 
% % fitting
% Vf = fminunc(@(V) chi2(V), V0, options);
% 
% %% plot
% figure(1)
% clf
% hold on
% % original
% semilogy(abs(y(lf)), 'b')
% % fitted
% semilogy(abs(yf(Vf)), 'r')
% % first guess
% semilogy(abs(yf(V0)), 'g')
% hold off
% set(gca, 'yscale', 'log')
% legend('Original', 'Fitted', 'Guess')

% Using fitSincFun
[Vf(2), yfit] = fitSincFun(abs(y(lf)));

%% Plot
figure(1)
clf
hold on
% original
semilogy(abs(y(lf)), 'b')
% fitted
semilogy(yfit, 'r')
hold off
set(gca, 'yscale', 'log')
legend('Original', 'Fitted')

fprintf('Found df:\t%.7f Hz\n', Vf(2)/tmax)
fprintf('Initial df:\t%.7f Hz\n', df)