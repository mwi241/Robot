clear ; clc

% Argument:
syms x1 x2;

% System of equations: unify with column vector
f1 = x1^2 - 10*x1 + x2^2 + 8;
f2 = x1*x2^2 + x1 - 10*x2 + 8;

% f1 = 4*x1 - x2 + 0.1*exp(x1)-1;
% f2 = -x1 + 4*x2 + 1/8*x1^2;
x = [x1;x2];
f = [f1;f2];

% initial value: unified column vector
a=-10;
b=-10;
i=0;
xfinal=[]
for a=[-10:1:10]
    for b=[-10:1:10]
x0 = [a;b];
error_dxk = double(0.0001 );
error_fkk = double(0.0001 );
num = 200;

% jacobi1 = [diff(f1,x1) diff(f1,x2);diff(f2,x1) diff(f2,x2)]
% Use the built-in function to find the Jacobian matrix directly:
jacobi = jacobian([f1,f2],[x1,x2]);

for k = 1:num
    Ak = double( subs(jacobi, x, x0) );
    bk = double( subs(f, x, x0) );
    dxk = pre_seidel(Ak,-bk,k); % step size
    x0 = x0 + dxk;
    fkk = double( subs(f, x, x0) ); % is simply used to judge
    if norm(dxk) < error_dxk | norm(fkk) < error_fkk
        break;
    end
end

if k < num
    x_result = x0;
   

else
    x_result = x0;
    
   
end

xfinal(:,end+1)=[a;b;x_result];


    end
end
%fprintf('f1 result is: %f\n',double( subs(f1,x,x0) ));
%fprintf('f2 result is: %f\n', double( subs(f2,x,x0) ));
%fprintf('dxk norm:%f\n',norm(dxk));
%fprintf('fkk norm:%f\n',norm(fkk));