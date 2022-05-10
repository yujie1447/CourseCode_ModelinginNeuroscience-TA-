function g = sigmoid(z,n)
if nargin<2
    n = 1;
end
%SIGMOID Compute sigmoid function
%   g = SIGMOID(z) computes the sigmoid of z.

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
%               vector or scalar).

g = ones(size(z))./(1+exp(-z*n));



% =============================================================

end
