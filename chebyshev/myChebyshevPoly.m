function A = myChebyshevPoly(n,x)
%--------------------------------------------------------------------------
% A = myChebyshevPoly(n,x)
% Chebyshev polynomials of the 1rst kind, Tn(x)
%--------------------------------------------------------------------------

x = x(:);

m = length(x);
A = zeros(n+1,m);

A(1,:) = ones(1,m);
if n > 1
   A(2,:) = x;
end
if n > 2
  for k = 3:n+1
     A(k,:) = 2*x.*A(k-1,:) - A(k-2,:);  %% recurrence relation
  end
end