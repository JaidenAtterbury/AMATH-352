clear all;
close all;

%% Given five data points, find least squares cubic between data points.

% Coefficient matrix of curve fitting problem.

A = [-8 4 -2 1; -1 1 -1 1; 0 0 0 1; 1 1 1 1; 8 4 2 1];

% Vector of knowns of curve fitting problem.

b = [0;1;0;1;-2];

% Full QR factorization.

[Q,R] = qr(A);

% Reduced QR factorization.

Qtilde = Q(:,1:4); % Since A is a 5 x 4 matrix, only want first 4 columns of Q.
Rtilde = R(1:4,:); % Since A is a 5 x 4 matrix, only want first 4 rows of R.

% Least squares solution. 

x_ls_soln = Rtilde \ (transpose(Qtilde)*b); % Solves Rtilde*x_ls_slon = transpose(Qtilde)*b

% Plot the data.

X = transpose(-2:1:2);
Y = b;

figure(1); % Give the figure a name.
scatter(X,Y,200,'or','LineWidth',3); % Creates a scatter plot of X,Y with red circles. Red circles have size 200. Red circles have linewidth 3.
title('Data Points for Cubic'); % Give the graph a title.
grid on; % Have MATLAB automatically generate a grid for your scatter plot.
xlim([-2 2]); % Set limits of x axis to be -2 to 2.
ylim([-4 4]); % Set limits of y axis to be -4 to 4.
hold on; % Superimpose other plots on top of scatter plot.
plot([-2 2],[0 0],'k','LineWidth',2); % Plot a x axis in black with linewidth 2.
plot([0 0],[-4 4],'k','LineWidth',2); % Plot a y axis in black with linewidth 2.
t = -2:0.001:2;
p = polyval(x_ls_soln,t); % Evaluate least squares ploynomial for t inbetween -2 and 2.

figure(2);
scatter(X,Y,200,'or','LineWidth',3);
title('Data Points with Interpolating Cubic'); % Give the graph a title.
grid on;
xlim([-2 2]);
ylim([-4 4]);
hold on;
plot([-2 2],[0 0],'k','LineWidth',2);
plot([0 0],[-4 4],'k','LineWidth',2);
plot(t,p,'b','LineWidth',3); % Plot least squares polynomial in blue with linewidth 3.
%% Given same five data points, find least squares quartic between data points.

% Coefficient matrix of curve fitting problem.

A = [16 -8 4 -2 1;1 -1 1 -1 1;0 0 0 0 1;1 1 1 1 1;16 8 4 2 1];

% Vector of knowns of curve fitting problem.

b = [0;1;0;1;-2];

% QR factorization

[Q,R] = qr(A);

Qtilde = Q(:,1:5);
Rtilde = R(1:5,:);

% Least squares solution. 

x_ls_soln = Rtilde \ (transpose(Qtilde)*b);

% NOTE: Since A is now square and full rank, it is invertible. Thus, there
% exists a unique x such that Ax = b. The least squares solution should
% coincide with this unique solution.
% Plot the data.

X = transpose(-2:1:2);
Y = b;

figure(3); % Give the figure a name.
scatter(X,Y,200,'or','LineWidth',3); % Creates a scatter plot of X,Y with red circles. Red circles have size 200. Red circles have linewidth 3.
title('Data Points for Quartic'); % Give the graph a title.
grid on; % Have MATLAB automatically generate a grid for your scatter plot.
xlim([-2 2]); % Set limits of x axis to be -2 to 2.
ylim([-4 4]); % Set limits of y axis to be -4 to 4.
hold on; % Superimpose other plots on top of scatter plot.
plot([-2 2],[0 0],'k','LineWidth',2); % Plot a x axis in black with linewidth 2.
plot([0 0],[-4 4],'k','LineWidth',2); % Plot a y axis in black with linewidth 2.
t = -2:0.001:2;
p = polyval(x_ls_soln,t); % Evaluate least squares ploynomial for t inbetween -2 and 2.

figure(4);
scatter(X,Y,200,'or','LineWidth',3);
title('Data Points with Interpolating Quartic'); % Give the graph a title.
grid on;
xlim([-2 2]);
ylim([-4 4]);
hold on;
plot([-2 2],[0 0],'k','LineWidth',2);
plot([0 0],[-4 4],'k','LineWidth',2);
plot(t,p,'b','LineWidth',3); % Plot least squares polynomial in blue with linewidth 3.