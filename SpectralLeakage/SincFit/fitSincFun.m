function [df, yfit] = fitSincFun( y2fit)
%FITSINCFUN(y2fit) fits a windowed portion of FFT to find the frequency shift. 
%   [df, yfit] = fitSincFun( y2fit), y2fit is a windowed portion of frequency spectrum
%   df is the frequency shift or frequency mismatch found from the fitting
%   and yfit is the resulted function used for the fitting to use for back
%   check.

% number of points to fit
np = length(y2fit);

% windowed guess function
w = hamming(np, 'periodic');
yf = @(V) V(1)*fftshift(fft(w.*exp(1j*2*pi*V(2)*(0:np-1)/np).')/np);

% chi2 based on Abs
chi2 = @(V) sum((y2fit - abs(yf(V))).^2);

% fitting options
options = optimoptions(@fminunc,'display', 'none','TolFun', 1e-10, 'TolX', 1e-10, 'Algorithm', 'quasi-newton');

% first guess from position and intensity of FFT
[V0(1), V0(2)] = max(y2fit);
V0(2) = V0(2)-np/2-1;   % shift

% fitting
Vf = fminunc(@(V) chi2(V), V0, options);

% frequency shift in normalized frequencies
df = Vf(2);

% resulted fitting function
yfit = abs(yf(Vf));

end

