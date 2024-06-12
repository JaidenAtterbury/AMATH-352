%% Setup

format long;

x = [0, 1, 2, 3];
y = [1, 2, -1, 2];

%% Calculations:

% Set up coefficient matrix:
A = [0, 0, 0, 0, 1;
     1, 1, 1, 1, 1;
     16, 8, 4, 2, 1;
     81, 27, 9, 3, 1];

% Set up vector of knowns:
b = [1; 2; -1; 2];

% Set up new A for least-squares:
A_new = [A; eye(5)];

% Set up new b for least-squares:
b_new = [b; zeros(5,1)];

% Set up least squares using normal equation:
At = transpose(A_new);
AtA = At*A_new;
Atb = At*b_new;

% Least squares solution using normal equation:
nels = AtA\Atb;

% Set up least squares using QR factorization:
[Q, R] = qr(A_new);
Q_tilde = Q(:, 1:5);
R_tilde = R(1:5, :);
Qt = transpose(Q_tilde);
Qtb = Qt*b_new;

% Least squares solution using QR factorization:
qrls = R_tilde\Qtb;

% Pseudo inverse of A
A_plus = pinv(A);

% Least squares solution using pseudo-inverse
Apb = A_plus*b;
x_star = Apb;

% Norms of solutions:
norm_normal = norm(nels);
norm_pseudo = norm(x_star);

%% Plotting:

% Create quadratics:
s = -1:0.001:4;
normal = polyval(nels, s);
pseudo = polyval(x_star, s);

% Create a new plotting figure:
figure(1);

% Plots the data
scatter(x, y, 'ro','LineWidth', 3);

% Add a title and axis labels:
title('Least Squares Solution using Normal Equation and Pseudo Inverse');
xlabel('x values');
ylabel('y values');
axis([-1 4 -2 3]);
hold on;
plot(s, normal, 'k');
hold on;
plot(s, pseudo, 'm');
legend('Data points', 'Normal Equation', 'Psedo-Inverse');

