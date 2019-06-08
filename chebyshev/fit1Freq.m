

npoints = 150;
fstep = 1/(length(Bfft)*Tinterval);

l = f(2)/fstep +1+ (-npoints/2:npoints/2-1);
y2fit = double(Bfft(l));


% x for the basis functions
xVec = @(L,norm) (-L/2:L/2-1)/norm;
xVec = @(L,norm) linspace(-L/2, L/2, L)/norm;
%xBasFun0 = xVec(LBasFun0, LBasFun0/2);


n = 45;
LBasFun = npoints;
xBasFun = xVec(LBasFun, LBasFun/2);
basFun = myChebyshevPoly(n, xBasFun);

dePhase = sqrt(1j);
%dephase = 1;
BasFun = dePhase*fftshift(fft(basFun, [], 2), 2)/LBasFun;

fun = @(c) real(BasFun).'*c(:,1) + 1j*imag(BasFun).'*c(:,2);
chi2 = @(c) sum( (real(fun(c)) - real(y2fit)).^2 + (imag(fun(c)) - imag(y2fit)).^2 )/sum(abs(y2fit));

c0 = rand(n+1,2);

% fitting options
options = optimoptions(@fminunc,'display', 'iter','TolFun', 1e-12, 'TolX', 1e-12, 'Algorithm', 'quasi-newton', 'MaxFunEvals', 1e4);

% fitting
cf = fminunc(@(c) chi2(c), c0, options);

% fitting function
yfit = fun(cf);

% abs coefficients
C = abs(cf(:,1)+1j*cf(:,2));

% fun in time
imp = 1./ifft(ifftshift(yfit))*LBasFun;

figure(1)
clf

subplot(2,1,1)
hold on
plot(abs(y2fit), '.')
plot(abs(yfit), 'r')
hold off
set(gca, 'yscale', 'log')

subplot(2,1,2)
semilogy(0:n, C)

figure(2)
clf
subplot(2,1,1)
plot(real(imp))

subplot(2,1,2)
plot(imag(imp))
