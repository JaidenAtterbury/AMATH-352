% Define the parameter A, the coefficient matrix A, and the right-hand side
% vector b.
epsilon = 10^-16;
A = [epsilon, 1; 1,2;];
b = [3; 5];

% Form the augmented matrix M and use the code given in Lecture 4 for
% reduction to upper triangular form via Gaussian elimination
M = [A,b];
[m,n] = size(M);
for j=1:m-1
    for i = j+1:m
        l_ij = M(i,j)/M(j,j);
        M(i,j:n) = M(i,j:n) - l_ij*M(j,j:n);
    end
end

% Use the back substitution code given in Homework 2, Exercise 1 to solve
% the system
x = M(:,m+1);
x(m) = M(m,m+1)/M(m,m);
for i = m-1:-1:1
    SUM = 0;
    for j = i+1:m
        SUM = SUM + M(i,j)*x(j);
    end
    x(i) = (M(i,n) - SUM)/M(i,i);
end
disp(x)
% x = [0; 3], which is incorrect.

% Using partial pivoting, we get the right answer. First swap the order of
% the rows of M (using an elementary matrix)
M = [0 1; 1 0]*[A,b];

% Perform Gaussian elimination and back substitution
[m,n] = size(M);
for j=1:m-1
    for i = j+1:m
        l_ij = M(i,j)/M(j,j);
        M(i,j:n) = M(i,j:n) - l_ij*M(j,j:n);
    end
end
y = M(:,m+1);
y(m) = M(m,m+1)/M(m,m);
for i = m-1:-1:1
    SUM = 0;
    for j = i+1:m
        SUM = SUM + M(i,j)*y(j);
    end
    y(i) = (M(i,n) - SUM)/M(i,i);
end
disp(y)
% y = [-1; 3] which is correct! YAY Pivoting!