% "Universal Convergence" Gauss-Seidel Iteration Method after Preprocessing of Linear Equations
% Ignore all kinds of problems, as long as there is a solution, it will definitely be solved.

function[x] = pre_seidel(A,b,n)

% preprocessing: it's that simple
b = A'*b;
A = A'*A;
% Here is the normal Gauss-Seidel operation:
D = diag(diag(A));
L = tril(A,-1); % Lower triangular matrix that moves down one square to the left;
U = triu(A,1); % Upper triangular matrix shifted up one square to the right;
B2 = -inv(D+L)*U; % Seidel iteration matrix, used to calculate and judge whether convergence or not;
g2 = inv(D+L)*b;

radius = max(abs(eig(B2))); % eigenvalues ​​may be complex numbers, abs takes absolute value + modulo
fprintf('The %dth time to solve the linear equation system, the current universal Seidel iteration matrix spectral radius is (the smaller the better): %.4f\n',n,radius);
    
% Iterative calculation part:
x = zeros(length(b),1); % Initially iterate a 4x1 matrix (column matrix): the initial value is all 0
error = 0.0001; % Just use a single precision, which can be modified
count = 0; % iteration counter
while 1
    tmp = B2*x + g2;
    if max(abs(tmp - x)) < error
        break;
    end
    x = tmp;
    count = count + 1;
end