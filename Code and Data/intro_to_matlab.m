%% AN INTRODUCTION TO MATLAB FOR AMATH 352

clear all;
close all;


% It's good practice to start off all MATLAB scripts with these two lines
% of code. The first wipes MATLAB's memory of variables that you were
% previously working with. The second closes any files you were working
% with or any figures that you had created.

% A single percent sign allows you to add comments to your code. A double
% percent sign creates new sections of your code. This is helpful for codes
% that span multiple homework exercises.

%% FLOATING POINT REPRESENTATION

% Every real/complex number has to be represented in a way that can be 
% understood by MATLAB or any other language. Most times, numbers cannot
% be represented exactly, as most numbers have an infinite decimal 
% expansion that requires an infinite amount of memory to store on 
% a computer. 

% The standard way numbers are represented in MATLAB and other 
% commercially used languages is the IEEE (Institute of Electrical
% and Electronics Engineers) double precision floating point 
% representation. Studying double precision floating point
% representation would require a whole course in itself, but
% here are the key takeaways:

% 1. The largest number that can be represented in floating point
%    representation is 10^308. A number larger than this 
%    cannot be represented as a floating point number. This causes
%    overflow: the computer is unable to store a number of this
%    large magnitude.

% 2. The smallest number that can be represented in floating point
%    representation is 10^(-308). A number smaller than this
%    cannot be represented as a floating point number. This causes
%    underflow: the computer is unable to store a number of this 
%    small magnitude. 

% 3. The floating point representation of a number never introduces 
%    greater relative error than 2^(-53), or roughly 1.11e-16. If
%    x is a real number and xtilde is its floating point equivalent,
%    then |x - xtilde|/|x| <= 2^(-53). We call 2^(-53) machine 
%    precision, or machine epsilon.

% 4. Since a number will never incur more relative error than machine
%    precision when converted to floating point, one can expect that
%    the converted number will retain 15 to 17 significant digits
%    of the unconverted number.

% Because numbers inherently now come with their own numerical round off
% error, we will have to worry about whether or not the algortihms we 
% construct in linear algebra give reliably accurate answers when
% performed on a computer. (That is, we will have to ask ourselves 
% whether numerical round off will destroy the accuracy of our 
% algorithms.)

% By default, MATLAB prefers to only show you 4 significant digits of
% a number in floating point representation. If you wish to see all 15
% to 17 significant digits, you must first type the following command:

format long;

% If we now type a number (for example, pi) and run the code, the 
% floating point representation of that number will be displayed
% to the Command Window with 15 to 17 significant digits of accuracy. 

pi

% Note: semicolons after a line of code supresses MATLAB from displaying
%       the numerical value of that line to the Command Window. If you
%       did not want pi to be displayed to the Command Window, you 
%       would instead write "pi;". The use of semicolons to suppress/
%       display lines of code is useful for debugging your code.

% That's all we need to know about the floating point representation of
% numbers. To learn more, check out Trefethen and Bau's book or take
% Amath 584 next fall. 

%% MATRICES AND VECTORS 

% Let's see how MATLAB handles matrices and vectors. We would expect
% a software called "Matrix Laboratory" to handle these objects fairly
% intuitively, and indeed, MATLAB does.

A = [1 0 3 4; 5 6 0 8; 9 10 11 0; 13 14 15 16]; 
% Creates a 4x4 matrix called A. First row is 1 0 3 4, second row is 5 6 0 
% 8, third row is 9 10 11 0, fourth row is 13 14 15 16.

[m n] = size(A);
% Assigns to the variable m the number of rows of A. Assigns to the
% variable n the number of columns of A.

A_23 = A(2,3);
% Assigns the variable A_23 to the entry in the second row, third column
% of A.

R_1 = A(1,:);
% Assigns the variable R_1 to the first row of A.

C_3 = A(:,3);
% Assigns the variable C_3 to the third column of A.

A_m = A(1:2,[1 3]);
% Assigns the variable A_m to the 2x2 matrix obtained by keeping only those
% entries of A that are in the first or second row of A and in the first or
% thrid column of A.

b = [1;0.5;0.5;1];
% Creates a 3x1 column vector.

A_aug_b = [A,b];
% Concatenate (fancy word for append) column vector b to the last column of
% A. A_aug_b becomes a 3x4 matrix.

r = [ 1 0.5 0.5 1];
% Creates a 1x3 row vector.

A_aug_r = [A;r];
% Concatenate row vector r to the last row of A. A_aug_r becomes a 4x3
% matrix.

x = A\b;
% Solves the problem Ax = b, whenever possible. This is the famous MATLAB
% backslash command. We'll learn a little bit more about what's going on
% under the hood of this command as the course progresses. 

Id = eye(4);
% Generates a 4x4 identity matrix.

F = 4*Id;
% Computes the scalar multiplication of Id by 4.

Su = A+Id;
% Computes the matrix addition of A and Id.

P = A*F;
% Computes the matrix multiplication of A and F.

A_inv = inv(A);
% Computes the matrix inverse of A, whenever it exists.

Sq = A.^2;
% Squares every entry of the matrix A. Any dot type operation will perform
% the operation entry-wise.

%% FOR LOOPS, IF STATEMENTS, AND WHILE LOOPS

% The FOR LOOP, IF STATEMENT, and WHILE LOOPS are all designed to 
% handle algorithms that are repetative in nature or require 
% decisions to be made at each step in an algorithm.

% THE FOR LOOP

% Suppose we wanted to add up the entries of the second column of the
% matrix A above. One way of doing this is to do the following:

C_2_sum_v1 = A(1,2) + A(2,2) + A(3,2) + A(4,2);

% This is fine for small matrices, but when we work with larger matrix
% sizes, this becomes cumbersome. A better way is to use FOR LOOPS. FOR
% LOOPS are a way of telling your program to execute a very repetive
% procedure in very few lines of code. Here's how the FOR LOOP would work
% for computing the sum of the entries in the second column of A:

C_2_sum_v2 = 0; 
% The column sum starts out at zero when we haven't summed any entries yet.
for i = 1:4 
% i here represents an index. This index will correspond to what row we 
% are looking at.

C_2_sum_v2 = C_2_sum_v2 + A(i,2);
% You will go through this FOR LOOP four times. Each time you go through 
% the FOR LOOP, the value of C_2_sum_v2 gets updated by adding to it the 
% entry A(i,2).
end
% Always make sure to tell MATLAB where your FOR LOOP ends.

% For this problem of computing the column sum, there's a built-in MATLAB
% function that makes even the FOR LOOP obsolete for large enough matrices.
% Whenever applicable in this class, you may use this function. Here's how
% to obtain the sum of the second column of A in one line of code:

C_2_sum_v3 = sum(A(:,2));

% Suppose we did something a little more challenging and wanted to consider
% the sum of the entries in the second column of A that have an even row
% number. There are two FOR LOOPS you could use to set up the problem.

% FOR LOOP Solution #1:

C_2_even_sum_v1 = 0;
for i = 1:2
    C_2_even_sum_v1 = C_2_even_sum_v1 + A(2*i,2);
end

% FOR LOOP Solution #2:

C_2_even_sum_v2 = 0;
for i = [2,4]
    C_2_even_sum_v2 = C_2_even_sum_v2 + A(i,2);
end

% THE IF STATEMENT

% Sometimes we want to execute a specific task only if another condition is
% satisfied. Suppose we want to compute the sum of the entries of b that are 
% less than one. The sum part of the calculation can be handled with a FOR
% LOOP, but to ensure that we are summing entries that are less than one
% introduces an additional constraint. This will require an IF STATEMENT:

b_sum_1 = 0;
% Sum starts at zero before we add up entries.

for i = 1:length(b)
    % Index runs from 1 to the number of entries that b has.
    
    if b(i) < 1
    % If the ith entry of b is less than one, update the sum b_sum_1.
    b_sum_1 = b_sum_1+b(i);   
    end
    % Always end your IF STATEMENTS, just like with FOR LOOPS.
end

% A more complicated example is to sum the entries of A that are bigger
% than 5. Since the entries of A require two numbers to specify, we will
% need two nested FOR LOOPS to run over the possible rows and columns.
% Inside these FOR LOOPS will be an IF STATEMENT that ensures we only
% updated the sum if the entry is larger than 5:

A_sum_5 = 0;

for i = 1:m
% Remember m is number of rows of A from above.
    for j = 1:n
    % Remember n is number of columns of A from above.
    if A(i,j) > 5
        A_sum_5 = A_sum_5 + A(i,j);
    end
    end
end

% THE WHILE LOOP

% The WHILE LOOP is a FOR LOOP-IF STATEMENT hybrid. The WHILE LOOP will
% execute a repetative task only if a certain condition is satisfied. As
% soon as the condition is no longer satisfied, the WHILE LOOP stops. This
% can be potentially tricky business if you don't set up your loops
% correctly. For instance, if your condition is always true, your WHILE
% LOOP will continue indefinitely and your program will never terminate. If
% this ever happens, ctrl+C will stop your program (on PC) and command+. 
% (on Mac). Let's take an example.

% Suppose we want to know what power we can raise A to before  
% the maximum element in the matrix exceeds 1e6.  (By raising A to a 
% power, I mean repeated matrix multiplication--not entry-wise.) In addition,
% suppose we'd like to know what the maximum element of A to this power is.
% Here's how we can do this:

i = 0;
% An index variable that will ultimately get updated to tell us how many 
% times A must be multiplied by itself to achieve a max entry above
% 1e6.

B = eye(size(A));
% Let B = A^0, i.e., the identity matrix whose size matches that of A. 

while max(max(B)) < 1e6
% The inner max function takes the max of the columns of A. The outer
% max takes the max of these maximum values, effectively giving us the
% maximum value of an entry for the matrix A. 

B = B*A;
% While condition is satisfied, update B by multiplying by A once.

i = i+1;
% While condition is satisfied, update i to mean that A can be multiplied
% by itself one more time. 
end
% Always end your WHILE LOOPS.

max_entry_A = max(max(B));
% Obtain the maximum entry of A^p where p is the power for which all 
% entries of A are still < 1e6 but such that A^(p+1) has at least one
% entry that exceeds 1e6. 

% For this problem, it so happens that A^4 is the largest power that
% can be taken before the maximum entry of the matrix exceeds 1e6.
% The maximum entry of A^4 is 372260.

% Let's take another example of a WHILE LOOP. Suppose we continue to square
% the entries of the vector b above. We continue this procedure until the
% minimum value of b is smaller than 1e-6. How many times
% can we do this squaring procedure, and what is the minimum value upon
% achieving being < 1e-6? Solution:

j=0;

while min(b) > 1e-6
    b = b.^2;
    j = j+1;
end

min_entry_b = min(b);

% This code predicts that the squaring procedure can be done five times, at
% which point the minimum entry of b becomes roughly 2.328e-10.

%% SAVING YOUR DATA TO .DAT FILES

% This is delightfully simple. Suppose you have your matrix A that you'd
% like to save to a .dat file called "my_matrix_A.dat". Then, you need only
% call the following command:

save my_matrix_A.dat A -ascii 

% In general, after writing the save command, you provide the name of the
% file you want, followed by the variable you want to save to the file, and
% the -ascii option tells you what format to put the file in. For this
% class, we will be working with ascii files. 

% If instead you're given a .dat file, you can read the file and store
% its contents in a matrix as follows:

C = load('my_matrix_A.dat');

% Just be warned: you either need to give MATLAB the complete pathname of
% your file or have the file in the same folder as your MATLAB script.

%% CLOSING REMARKS

% Above is only the beginning of what you can do in MATLAB.
% We will learn some other things, such as plotting, later in the class,
% but I encourage you to explore on your own. I can help point you
% in the right direction, the best teacher when learning a new 
% language is Google (and especially StackExchange).