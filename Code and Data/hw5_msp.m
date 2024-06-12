%% Part (a):

% Make scatterplot of the data:

% Time intervals over which data has been collected:
t = 0:5:60;

% Altitude of rocket at time intervals
z = [108.5, 1482.5, 2651.7, 3476.1, 4165.7, 4562.9, 4678.0, 4604.3, 4217.6, 3632.9 2853.1, 1805.4, 503.4];

% Create plotting figure:
figure(1);

% Plot the data as a scatterplot:
scatter(t, z, 'om','LineWidth', 3);

% Add a title and axis labels:
title('Altitude in meters versus time in seconds of a SpaceX Rocket');
xlabel('Time (in seconds)');
ylabel('Altitude (in meters)');

%% Part (b):

% Set up the coefficient matrix for least squares:

% Time intervals over which data has been collected:
t = 0:5:60;

% length(t) by length(t) Vandermonde matrix: column j of this matrix is
% t^length(t)-j evaluated at each time interval t:
V = vander(t);

% Only want columns corresponding to quadratic, linear, and constant powers
% in t, i.e., the last three columns of V. This matrix is 13x3 and full
% rank:
A = V(:,end-2:end);

% Corresponsing 13x1 vector of knowns:
b = transpose(z);

% Solving the least squares problem using the normal equation:
x = (transpose(A)*A) \ (transpose(A)*b);


% Solving the least squares problem using the reduced QR factorization:

% Obtain the full QR factorization of A.
[Q, R] = qr(A);

% Obtain the reduced QR factorization of A.
Q_tilde = Q(:, 1:3);
R_tilde = R(1:3, :);

% Solve the least-squares problem in MATLAB by the reduced QR equation.
x = R_tilde \ (transpose(Q_tilde)*b);

% As can be seen from the output, the coefficients of the quadratic best
% fit polynomial of the above data are:-4.9, 297.7, and 127.2. Thus the
% best fit quadratic polynomial is z(t) = -4.9t^2 + 297.7t + 127.2.

%% Part (c):

% Done on paper.

%% Part (d):

% We will now generate a new figure that superimposes the scatterplot data
% with a sketch of the leat-squares quadratic that fits the data:

% Create a "continuum" of time intervals between 0 and 60 in steps of 1e-3:
s = 0:0.001:60;

% Evaluates quadratic with coefficients given by least-squares solution x
% at times s:
p = polyval(x,s);

% Create a new plotting figure:
figure(2);

% Plots the data
scatter(t, z, 'om','LineWidth', 3);

% Add a title and axis labels:
title('Altitude in meters versus time in seconds of a SpaceX Rocket');
subtitle('with least-squares quadratic overlaid')
xlabel('Time (in seconds)');
ylabel('Altitude (in meters)');

% Allows other plots to be superimposed atop the scatter plot
hold on;

% Plots the best fit quadratic:
plot(s,p);
