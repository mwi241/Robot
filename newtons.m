function varargout=newtons(fun,x0,ep,maxiter)
% NEWTONS Newton's method for finding the roots of a nonlinear system of equations
if nargin<4
    maxiter=500; % default maximum number of iterations
end
if nargin<3
    ep=1e-8; % default allowable error
end
if iscell(fun) % If a multivariate vector function and its Jacobian matrix function are given
    Jfun=fun{2}; % anonymous function form of Jacobian matrix
    fun=fun{1}; % anonymous function form of function
else
    if isa(fun,'function_handle') % function is given as an anonymous function
        fun=sym(fun); % Convert anonymous function to symbolic expression
    elseif ~isa(fun,'sym') % if fun is not a symbolic function
        error('fun must be a symbolic expression or an anonymous function.') % gives an error message
    end
    vars=symvar(fun); % Extract the symbolic variable of fun
    J=jacobian(fun,vars); % Find the Jacobian matrix of the multivariate vector function fun
    fun=matlabFunction(fun,'vars',{vars}); % Convert fun to the form of an anonymous function
    Jfun=matlabFunction(J,'vars',{vars}); % Convert J into the form of an anonymous function
end
iter=1; % number of iterations
xs(iter,:)=x0; % initial value of iteration sequence
exitflag=1; % Iterative divergence flag, 1 means iterative convergence, 0 means iterative divergence
while exitflag
    fx0=fun(x0(:).'); % Calculate the function value at x0
    Jx0=Jfun(x0(:).'); % Calculate the Jacobian at x0
    if iter>maxiter % If the Jacobian matrix is ​​singular or the number of iterations is greater than the maximum number of iterations
        exitflag=0; % think that the iteration is divergent, that is, the root is not reliable
        break % to exit the loop
    end
    x1=x0(:)-(Jx0'*Jx0)\Jx0'*fx0(:); % Newton iterative calculation
    xs(iter+1,:)=x1; % Store the iteration values ​​in the iteration sequence in turn
    if norm(x1(:)-x0(:))<=ep % The absolute value of the difference between the two iterations before and after is within the allowable error range
        break % to break out of the loop
    end
    x0=x1; % update iteration initial value
    iter=iter+1; % The number of iterations is accumulated
end
[varargout{1:5}]=deal(x1,... % The first output parameter is the function zero
    fun(x1(:).'),... % The function value at the zero point of the second output parameter
    exitflag,... % The third output parameter is the iteration convergence flag
    iter,... % The fourth output parameter is the number of iterations
    xs); % The fifth output parameter is the iteration sequence