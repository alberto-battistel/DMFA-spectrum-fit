
close all

npoints = 400;
fstep = 1/(length(Afft)*Tinterval);

% fit results
Vf = zeros(length(f),2);

% window function
w = blackmanharris(npoints, 'periodic');


%% Plot all

for i = 1:length(f)
    
    l = f(i)/fstep +1+ (-npoints/2:npoints/2-1);
    y2fit = abs(Afft(l));
    [Vf(i,:), yfit] = fitShiftFun( y2fit, w );
    
    % plot
    figure
    %subplot(ncol, nrow, i)
    hold on
    semilogy(abs(Afft(l)),'.')
    semilogy(yfit,'r')
    hold off
    set(gca, 'yscale', 'log')
    ylim([1e-12,1e-2])
    legend(sprintf('%d', f(i)))
end

% frequency shift
freqShift = Vf(:,2)-npoints/2-1; % in bins