C=zeros(314,314);
h1=0.5235;
h2=5.7595;
for i=1: size(xfinal,2)
    if abs(xfinal(3,i)-h1)<0.01
        t=1;
    elseif abs(xfinal(3,i)-h2)<0.01
        t=2;
    else
        t=0;
    end
    X=round(xfinal(1,i)/0.01);
    Y=round(xfinal(2,i)/0.01);
    C(Y,X)=t;
end
% pcolor(x,y,C)
image([0.01 3.14],[0.01 3.14],C,'CDataMapping','scaled')
set(gca,'YDir','normal');
