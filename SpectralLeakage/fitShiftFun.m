function [ Vf, yfit ] = fitShiftFun( y2fit, w )
%FITSHIFTFUN fit the windowed spectrum to find the position of a peak
%   [ Vf, yfit ] = fitShiftFun( y2fit, w ), y2fit is the section of spectrum to
%   fit, w is the window, and Vf are the fit results. Vf(1) is the modulus
%   of the peak and Vf(2) is its position in bins. The beans are counted as
%   in the section of the spectrum. yfit is the best fitting result
%   function.

% make sure data are double
y2fit = double(y2fit);

% windowed function
np = length(y2fit);
yf = @(V) abs(V(1)*fftshift(fft(w.*exp(1j*2*pi*(V(2)-np/2-1)*(0:np-1)/np).')/np));

% chi2 based on Abs
chi2 = @(V) sum((y2fit - yf(V)).^2);

% fitting options
options = optimoptions(@fminunc,'display', 'iter','TolFun', 1e-10, 'TolX', 1e-10, 'Algorithm', 'quasi-newton');

% first guess from position and intensity of FFT
[V0(1), V0(2)] = max(y2fit);
%V0(2) = 46;   % shift

% fitting
Vf = fminunc(@(V) chi2(V), V0, options);

% resulted fitting function
yfit = abs(yf(Vf));

% % plot
% figure
% hold on
% semilogy(y2fit, '.')
% semilogy(abs(yf(V0)), 'g')
% semilogy(yfit, 'r')
% hold off
% set(gca, 'yscale', 'log')

end

