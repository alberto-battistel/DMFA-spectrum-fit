
nPeriod = 3;

% Order of the basis function
nBasFun0 = 2;
nBasFun = 3;

% per la DC ci vuole una basis function piú large (piú punti)

% Length of the basis function for period for DC
LBasFun0 = L;

% Length of the basis function
LBasFun = 500;

f2fit = [ 0, 4, 8];



% x for the basis functions
xVec = @(L,norm) (-L/2:L/2-1)/norm;
xBasFun0 = xVec(LBasFun0, LBasFun0/2);
xBasFun = xVec(LBasFun, LBasFun/2);




%% Legendre polynomials
% Basis functions in time
basFun0 = legendreB(nBasFun0, xBasFun0).';
% basFun = legendreB(nBasFun, xBasFun).';

% Basis function in frequency
BasFun0 = fftshift(fft(basFun0, [], 2), 2)/LBasFun0;
% BasFun = fftshift(fft(basFun, [], 2), 2)/LBasFun;

%l1 = L0/2+1;
%BasFun0(2:end,l1) = 0;

%dePhase = (1+1i);
dePhase = 1;
BasFun = dePhase*BasFun;

% Separate in even and odd orders
BasFun0e = BasFun0(1:2:end,:);  % for real FFT
BasFun0o = BasFun0(2:2:end,:);  % for imag FFT

% BasFune = BasFun(1:2:end,:);
% BasFuno = BasFun(2:2:end,:);

Lb0e = size(BasFun0e,1);
Lb0o = size(BasFun0o,1);

% Lbe = size(BasFune,1);
% Lbo = size(BasFuno,1);
% Lb = size(BasFun,1);

Lf = length(lf);
y2fit = y(lf);

% [BasMate] = fillBasMat(Lf, BasFun0e, [], f2fit(1:firstF), true);
% [BasMato] = fillBasMat(Lf, BasFun0o, [], f2fit(1:firstF), true);

[BasMat0] = fillBasMat_V02(Lf, BasFun, f2fit);

ncr = 1:2:nBasFun0;
Ar = zeros(nPeriod * ncr, Lf);

Ar = BasMat0(1:2:nBasFun0,:);





% Real part
Lb0 = Lb0e;
Lb = Lb;
fun = @real;

BasMat = fun(BasMate);
Y2fit = fun(y2fit);

[ cr, yfite, residuals, sumResiduals ] = WLLS( [], BasMat, Y2fit);
sumResiduals