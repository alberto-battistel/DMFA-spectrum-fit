%% Cut a frequency range

f0 = f(22); % Hz
npoints = 100;

fstep = 1/(Nsample*Tinterval);
fstep = 1/(10e6*Tinterval);

l = f0/fstep +1+ (-npoints/2:npoints/2-1);
fvector = l-f0/fstep-1;

figure(1)
clf
subplot(2,1,1)
semilogy(fvector, abs(Afft(l)))
subplot(2,1,2)
semilogy(abs(Afft(l)))

% %% Plot all
% 
% ncol = 4;
% nrow = ceil(length(f)/ncol);
% nfig = nrow*ncol;
% 
% 
% 
% figure(1)
% clf
% for i = 1:length(f)
%     
%     l = f(i)/fstep +1+ (-npoints/2:npoints/2-1);
%     %fvector = (l-1)*fstep-f(i);
%     fvector = l-f(i)/fstep-1;
%     subplot(ncol, nrow, i)
%     semilogy(abs(Afft(l)))
%     ylim([1e-8,1e-2])
% end
