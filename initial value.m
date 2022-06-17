 clear;
clc;
syms x1 x2
l2=4;
l3=2;

f1 = l2*cos(x1)-l3*sin(x1)*sin(x2)-4;
f2 = l3*cos(x1)*sin(x2)+l2*sin(x1)-1;
f3=-l3*cos(x2)+3^(1/2);
fun=[f1;f2;f3];
x0 = [-1;pi/6-1];

newtons(fun,x0)