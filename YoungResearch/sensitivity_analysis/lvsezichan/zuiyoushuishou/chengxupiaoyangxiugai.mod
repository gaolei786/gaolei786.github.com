//*****************锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷***********************************
var
Lg Lb Kg Kb Ig 
Ib Yg Yb wg wb  
Qg Qb pg pb C 
M L Y Z mu 
e X D R Util A taue;

//*****************锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷***********************************
varexo epsilonA;
//*****************锟斤拷锟斤拷锟斤拷锟斤拷******************************
parameters
beta eta xi omegabar rhoL alphab alphag deltag deltab 
phig phib rhoA sigmaA
theta1 theta2 d0 d1 d2 deltaX epsilon
erow rhoY paib
kappa gamma zeta psi sbarg
Lgss1 Lbss1 Kgss1 Kbss1 Igss1 Ibss1 Ygss1 Ybss1 
wgss1 wbss1  Qgss1 Qbss1 pgss1 pbss1
Css1 Mss1 Lss1 Yss1 Zss1 muss1 ess1 Xss1  Dss1 Rss1 
Utils1;


%beta=0.995;
beta=0.99;%陈小亮和马啸（2016）		康立和龚六堂(2014)	王立勇和纪尧（2019）
eta = 2;%马勇和陈雨露(2014)	彭俞超和方意（2016）		陆磊（2020）
xi = 1;%马勇和陈雨露(2014)	彭俞超和方意（2016）		陆磊（2020）

%omegabar = 8.3849;
omegabar =   8.176553586458100;
rhoL = 1;
%alphab = 0.35;
%alphag = 0.33;
alphab = 0.37;%国际上通常取值1/3，但我国资本在收入份额中所占比例相对较高	陆磊（2020）
alphag = 0.33;
deltab = 0.025;%陈小亮和马啸（2016）		马勇和陈雨露(2014)	彭俞超和方意（2016）
deltag = 0.025;%陈小亮和马啸（2016）		马勇和陈雨露(2014)	彭俞超和方意（2016）
phig = 10;%陆磊（2020）
phib = 10;%陆磊（2020）
%rhoA = 0.95;
rhoA = 0.8;%卞志村等（2019）			卞志村和杨源源（2016）
%sigmaA = 0.007;
sigmaA =0.0246;  %	黄赜琳和朱保华（2015）
%theta1 = 0.0335;
theta1 = 0.028669103371435;
theta2 = 2.6;
d0 = -0.0076;
%d1 = 1.522550102017574*10^(-5);
%d2 =  3.709902078663939*10^(-8);
d1 =     5.293399423930891*10^(-05);
d2 =     4.484237362343470*10^(-07);

%deltaX = 0.9965;
deltaX = 0.9917; %Nordhaus（1991），Reily（1992），Falk和Mendelsohn（1993），Moore和Braswell（1994），Angelopoulos（2013），Annicchiarico（2015）及我国实际	程郁泰（2017）
%epsilon = 1;
epsilon = 0.843754;%盛仲麟（2016）		利用1995-2014年各省域的碳排放量与GDP测算
%erow = 3.1499;
erow = 1.893999897868008;
rhoY = 2;
%paib = 0.3326;
paib = 0.424770796891064;
% kappa = 0.3409;
kappa = 0.482844896912568 ;
gamma = 0.972;
% zeta = 0.003;
zeta = 0.000749786277790;
psi = 0.0001;
sbarg = 0.5;

% tauess1 = 0.0000000001;
tauess1 = 0.0000000001;
Ass1 = 1;
Ygss1 = 0.744060643812242     ;
Ybss1 =  0.608050508967800;
Yss1 = (paib^(1/rhoY)*Ybss1^((rhoY-1)/rhoY)+(1-paib)^(1/rhoY)*Ygss1^((rhoY-1)/rhoY))^(rhoY/(rhoY-1));
pbss1 = (paib*Yss1/Ybss1)^(1/rhoY);
pgss1 = ((1-paib)*Yss1/Ygss1)^(1/rhoY);
muss1 = (tauess1*Ybss1^(epsilon-1)/theta1/theta2)^(1/(theta2-1));
Zss1 = theta1*muss1^theta2*Ybss1;
ess1 = (1-muss1)*Ybss1^epsilon;
Xss1 = (ess1 + erow)/(1-deltaX);
value1 = (1-alphab)*Ybss1*(pbss1-theta1*muss1^theta2-tauess1*(1-muss1)*epsilon*Ybss1^(epsilon-1));
value2 = (1-alphag)*pgss1*Ygss1;
Lbss1 = (value1/omegabar)^(1/(1+rhoL));
Lgss1 = (value2/omegabar)^(1/(1+rhoL));
Lss1 = (Lbss1^(1+rhoL)+Lgss1^(1+rhoL))^(1/(1+rhoL));
wbss1 = omegabar*Lbss1^rhoL;
wgss1 = omegabar * Lgss1^rhoL;
%d1 = d1/(Xss1/2030);
%d2 = d2/(Xss1/2030)^2;
Kgss1 = (Ygss1/Ass1/(1-d0-d1*Xss1-d2*Xss1^2)/Lgss1^(1-alphag))^(1/alphag);
Kbss1 = (Ybss1/Ass1/(1-d0-d1*Xss1-d2*Xss1^2)*Lbss1^(alphab-1))^(1/alphab);
%Kgss1 = (Ygss1/Ass1/(1-0.052)/Lgss1^(1-alphag))^(1/alphag);
%Kbss1 = (Ybss1/Ass1/(1-0.052)*Lbss1^(alphab-1))^(1/alphab);
Qgss1 = 1;
Qbss1 = 1;
Igss1 = Kgss1*deltag;
Ibss1 = Kbss1*deltab;
Dss1=Qgss1*Kgss1+Qbss1*Kbss1;
Mss1 = beta;
Rss1 = 1/Mss1;
Css1 = Yss1 - Igss1 - Ibss1 - Zss1 ;
Utilss1 = 1/(1-eta)*(Css1 - omegabar*Lss1^(1+xi)/(1+xi))^(1-eta);
//************************模锟斤拷******************
model;
L = (Lb^(1+rhoL)+Lg^(1+rhoL))^(1/(1+rhoL)); //equation1
M = beta*(C-omegabar*L^(1+xi)/(1+xi))^(-eta)/(C(-1)-omegabar*L(-1)^(1+xi)/(1+xi))^(-eta);//equation2
1=M(+1)*R;//equation3
wg = omegabar*Lg^rhoL;//equation4
wb = omegabar*Lb^rhoL;//equation5
Y = (paib^(1/rhoY)*Yb^((rhoY-1)/rhoY)+(1-paib)^(1/rhoY)*Yg^((rhoY-1)/rhoY))^(rhoY/(rhoY-1));//equation18
Yg = (1-d0-d1*X-d2*X^2)*A*Kg(-1)^alphag*Lg^(1-alphag);//equation19
Yb = (1-d0-d1*X-d2*X^2)*A*Kb(-1)^alphab*Lb^(1-alphab);//equation20
pb = (paib*Y/Yb)^(1/rhoY);//equation21
pg = ((1-paib)*Y/Yg)^(1/rhoY);//equation22
X = deltaX *X(-1)+e+erow;//equation23
e=(1-mu)*Yb^epsilon;//equation24
Z = theta1*mu^theta2*Yb;//equation25
wb = (1-alphab)*Yb/Lb*(pb-theta1*mu^theta2-taue*(1-mu)*epsilon*Yb^(epsilon-1));//equation26
taue = Yb^(1-epsilon)*theta1*theta2*mu^(theta2-1);//equation27
R(+1) = (alphab*Yb(+1)/Kb*(pb(+1)-theta1*mu(+1)^theta2-taue*(1-mu(+1))*epsilon*Yb(+1)^(epsilon-1))+(1-deltab)*Qb(+1))/Qb;
wg = (1-alphag)*pg*Yg/Lg;//equation29
R(+1) = (alphag*pg(+1)*Yg(+1)/Kg + (1-deltag)*Qg(+1))/Qg;//equation30
Qg = 1 + phig/2*(Ig/Ig(-1)-1)^2+phig*(Ig/Ig(-1)-1)*Ig/Ig(-1)-M(+1)*phig*(Ig(+1)/Ig-1)*(Ig(+1)/Ig)^2;//equation31
Qb = 1 + phib/2*(Ib/Ib(-1)-1)^2+phib*(Ib/Ib(-1)-1)*Ib/Ib(-1)-M(+1)*phib*(Ib(+1)/Ib-1)*(Ib(+1)/Ib)^2;//equation32
Kg = (1-deltag)*Kg(-1)+Ig;//equation33
Kb = (1-deltab)*Kb(-1)+Ib;//equation34
D=Qg*Kg+Qb*Kb;
Y=C+Ig+Ib+Z+phig/2*(Ig/Ig(-1)-1)^2*Ig+phib/2*(Ib/Ib(-1)-1)^2*Ib;//equation37
Util = 1/(1-eta)*(C - omegabar*L^(1+xi)/(1+xi))^(1-eta);
log(A) = rhoA*log(A(-1))+sigmaA*epsilonA;
end;

initval;
Lg=Lgss1;
Lb=Lbss1;
Kg=Kgss1;
Kb=Kbss1;
Ig=Igss1;
Ib=Ibss1;
Yg=Ygss1;
Yb=Ybss1;
wg=wgss1;
wb=wbss1;
Qg=Qgss1;
Qb=Qbss1;
pg=pgss1;
pb=pbss1;
C = Css1;
M=Mss1;
L=Lss1;
Y=Yss1;
Z=Zss1;
mu=muss1;
e=ess1;
X=Xss1;
D=Dss1;
R=Rss1;
A = Ass1;
taue = tauess1;
Util = Utilss1;
end;

shocks;
    var epsilonA; stderr 0.01;
end;

planner_objective  Util;
ramsey_policy(order =1, irf = 20, planner_discount = 0.995,nograph);
