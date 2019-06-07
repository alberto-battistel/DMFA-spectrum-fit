%% Chebyshev polynomials


x = -1:0.01:1;
n = 5;
m = length(x);
y = zeros(n+1, m);

A = myChebyshevPoly2(n, x);

figure(1)
clf
color = jet(n+1);
hold on

for d = 0:n
    plot(x, A(d+1,:), 'color', color(d+1,:))
end

hold off


