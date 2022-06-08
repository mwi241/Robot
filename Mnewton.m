clear ; clc;

% Argument:
syms x1 x2;

% System of equations: unify with column vector
f1 = x1^2 - 10*x1 + x2^2 + 8;
f2 = x1*x2^2 + x1 - 10*x2 + 8;
x = [x1;x2];
f = [f1;f2];

% initial value: unified column vector
x0 = [5;4];
error_z = double( input('precision of z-norm:') );
error_fk = double( input('precision of fk norm:') );
num = input('stop iteration count:');

% Use the built-in function to find the Jacobian matrix directly:
jacobi = jacobian([f1,f2],[x1,x2]);

% Judgment of how much small loop m takes: It is related to the number of equations N, find the maximum value of w
syms M N;
mn0 = [N;M];
% The parameter xzn is the number of equations:
xzn = length(x);
% Original efficiency comparison equation:
w = (N+1)*log(M+1)/( (N+M)*log(2) );
% Let the w equation find the xzm value of the maximum value:
xzm = double( solve( diff( subs(w,N,xzn),M ) ) );
mn1 = [xzn;xzm];
% Maximum efficiency value:
wax = double( subs(w,mn0,mn1) );

% Start correcting the Newton iteration:
xki = x0;
for k = 1:num
    fk = double( subs(f,x,x0) );
    Ak = inv( double( subs(jacobi, x, x0) ) );
    for m = 1:round(xzm)
        b = fk;
        x0 = x0 - Ak*b;
        fki = double( subs(f,x,x0) );
        fk = fki;
        z = Ak*b;
    end
    if norm(z) < error_z | norm(fk) < error_fk
        break;
    end
end

if k < num
    x_result = x0;
    fprintf('The precision has reached the requirement, the iteration ends early!\n');
    fprintf('After %d iterations, the approximate solution is:\n',k);
    x_result
else
    x_result = x0;
    fprintf('The number of iterations has reached the upper limit!\n');
    fprintf('It seems to be:\n',k);
    x_result
end

fprintf('f1 result is: %f\n',double( subs(f1,x,x0) ));
fprintf('f2 result is: %f\n', double( subs(f2,x,x0) ));
fprintf('z norm: %f\n',norm(z));
fprintf('fk norm:%f\n',norm(fk));