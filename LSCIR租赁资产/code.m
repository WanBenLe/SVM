Data=xlsread('��ծ.xls');
x=Data(1:end-1);
TimeStep=1/250;
dx=diff (Data);
dx=dx./x.^0.5;
regr=[TimeStep./x.^0.5,  TimeStep*x.^0.5];
drift=regr\dx;
res=regr*drift-dx;
alpha=-drift (2) ;
R=-drift (1) /drift (2);
sigma=sqrt (var (res, 1) /TimeStep);
InitialParams=[alpha R sigma]

IimeStep=1/250;
x=Data(1:end-1);
dx=diff(Data);
dx=dx./x.^0.5;
regr=[TimeStep./x.^0.5,TimeStep*x.^0.5];
drift=regr\dx;
res=regr*drift-dx;
alpha=-drift(2);
R=-drift(1)/drift(2);
sigma=sqrt(var(res, 1)/TimeStep);
InitialParams=[alpha R sigma];
DataA=Data(2:end);
DataB=Data(1 :end-1);
Leng=length(Data);
c=@(Params)2*Params(1)/(Params(3)^2*(1-exp(-Params(1)*TimeStep)));
q=@(Params)2*Params(1)*Params(2)/Params(3)^2-1;
u=@(Params)c(Params)*exp(-Params(1)*TimeStep)*DataB;
v=@(Params)c(Params)*DataA;
z=@(Params)2*sqrt(u(Params).*v(Params));
bf=@(Params)besseli(q(Params),z(Params),1);
lnL=@(Params)-(Leng-1)*log(c(Params))+sum(u(Params)+v(Params)-0.5*q(Params)*log(v(Params)./u(Params))-log(bf(Params))-z(Params));
[Params,Pval]=fminsearch(lnL,[0.1,0.01,0.1])