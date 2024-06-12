%% Setup:

% Create the 20x10 matrix A with the 10x10 all ones matrix on top of the
% 10x10 identity matrix multiplies by 10^-8.
A = [ones(10); 10^-8 * eye(10)];

% Create the vector of knowns to be the 20x1 ones matrix.
b = ones([20, 1]);

%% Part (a):

% Solve the least-squares problem in MATLAB using the normal equation.
x = (transpose(A)*A) \ (transpose(A)*b);

%% Part (b):

% Obtain the full QR factorization of A.
[Q, R] = qr(A);

% Obtain the reduced QR factorization of A.
Q_tilde = Q(:, 1:10);
R_tilde = R(1:10, :);

% Solve the least-squares problem in MATLAB by the reduced QR equation.
x = R_tilde \ (transpose(Q_tilde)*b);

% Is this solution reasonable?
b_approx = A*x;
