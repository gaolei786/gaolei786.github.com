//*****************内生变量定义***********************************
var
Lg Lb Kg Kb Ig Ib Yg Yb Sg Sb 
wg wb Rkg Rkb Qg Qb pg pb
C M L Y Z mu e X N W sg D R 
chig chib nu phi Gamma Omega
;

//*****************外生变量定义***********************************
varexo
taue taub taug  A
;
//*****************参数定义******************************
parameters
beta eta xi omegabar rhoL alphab alphag deltag deltab 
phig phib rhoA sigmaA
theta1 theta2 d0 d1 d2 deltaX epsilon
erow rhoY paib
kappa gamma zeta psi sbarg
Lgss1 Lbss1 Kgss1 Kbss1 Igss1 Ibss1 Ygss1 Ybss1 Sgss1 Sbss1 
wgss1 wbss1 Rkgss1 Rkbss1 Qgss1 Qbss1 pgss1 pbss1
Css1 Mss1 Lss1 Yss1 Zss1 muss1 ess1 Xss1 Nss1 Wss1 sgss1 Dss1 Rss1 
chigss1 chibss1 nuss1 phiss1 Gammass1 Omegass1 

Lgss2 Lbss2 Kgss2 Kbss2 Igss2 Ibss2 Ygss2 Ybss2 Sgss2 Sbss2 
wgss2 wbss2 Rkgss2 Rkbss2 Qgss2 Qbss2 pgss2 pbss2
Css2 Mss2 Lss2 Yss2 Zss2 muss2 ess2 Xss2 Nss2 Wss2 sgss2 Dss2 Rss2 
chigss2 chibss2 nuss2 phiss2 Gammass2 Omegass2 
;

%predetermined_variables M;
%beta=0.995;
beta=0.99;%陈小亮和马啸（2016）		康立和龚六堂(2014)	王立勇和纪尧（2019）
eta = 2;%马勇和陈雨露(2014)	彭俞超和方意（2016）		陆磊（2020）
xi = 1;%马勇和陈雨露(2014)	彭俞超和方意（2016）		陆磊（2020）

%omegabar = 8.3849;
omegabar =   7.786260946547598;
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
theta1 =0.032581447439786;
theta2 = 2.6;
d0 = -0.0076;
%d1 = 1.522550102017574*10^(-5);
%d2 =  3.709902078663939*10^(-8);
d1 =     6.176530605680263*10^(-05);
d2 =     6.105320353459878*10^(-07);

%deltaX = 0.9965;
deltaX = 0.9917; %Nordhaus（1991），Reily（1992），Falk和Mendelsohn（1993），Moore和Braswell（1994），Angelopoulos（2013），Annicchiarico（2015）及我国实际	程郁泰（2017）
%epsilon = 1;
epsilon = 0.843754;%盛仲麟（2016）		利用1995-2014年各省域的碳排放量与GDP测算
%erow = 3.1499;
erow = 1.623192469746612;
rhoY = 2;
%paib = 0.3326;
paib = 0.302009395017841;
% kappa = 0.3409;
kappa = 0.482844896912570;
gamma = 0.972;
% zeta = 0.003;
zeta = 0.000749786277790;
psi = 0.0001;
sbarg = 0.6;


tauess1 = 0.0000000001;
Ass1 = 1;
taubss1 = 0.0000000001;
taugss1 = 0.0000000001;
Ygss1 =    0.744116047364193    ;
Ybss1 =    0.608011442539010 ;
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
Kgss1 = (Ygss1/Ass1/(1-d0-d1*Xss1-d2*Xss1^2)/Lgss1^(1-alphag))^(1/alphag);
Kbss1 = (Ybss1/Ass1/(1-d0-d1*Xss1-d2*Xss1^2)*Lbss1^(alphab-1))^(1/alphab);
%Kgss1 = (Ygss1/Ass1/(1-0.052)/Lgss1^(1-alphag))^(1/alphag);
%Kbss1 = (Ybss1/Ass1/(1-0.052)*Lbss1^(alphab-1))^(1/alphab);
Qgss1 = 1;
Qbss1 = 1;

Rkbss1 = (alphab*Ybss1/Kbss1*(pbss1-theta1*muss1^theta2-tauess1*(1-muss1)*epsilon*Ybss1^(epsilon-1))+(1-deltab)*Qbss1)/Qbss1;
Rkgss1 = (alphag*pgss1*Ygss1/Kgss1+(1-deltag)*Qgss1)/Qgss1;
Igss1 = Kgss1*deltag;
Ibss1 = Kbss1*deltab;
Sbss1 = Kbss1;
Sgss1 = Kgss1;

Mss1 = beta;
Rss1 = 1/Mss1;

Wss1 = Qbss1*Sbss1 + Qgss1*Sgss1;
sgss1 = Qgss1*Sgss1/Wss1;

Dss1 = ((1+taubss1)*Qbss1*Sbss1 + (1+taugss1)*Qgss1*Sgss1+psi/2*(sgss1-sbarg)^2*Wss1-gamma*(Rkgss1*Qgss1*Sgss1+Rkbss1*Qbss1*Sbss1)-zeta*(Qgss1*Sgss1+Qbss1*Sbss1))/(1-gamma*Rss1);
Nss1 = gamma*(Rkgss1*Qgss1*Sgss1+Rkbss1*Qbss1*Sbss1-Rss1*Dss1)+zeta*(Qgss1*Sgss1+Qbss1*Sbss1);
%Nss1 = 3.276;
phiss1 = kappa*Wss1/Nss1;
Omegass1 = Mss1*(1-gamma+gamma*phiss1);
%Omegass1 = Mss1*(1-gamma+gamma/beta*phiss1);
chibss1 = Omegass1*(Rkbss1-(1+taubss1)*Rss1);
chigss1 = Omegass1*((Rkgss1-Rkbss1)-(taugss1-taubss1)*Rss1);
nuss1 = Omegass1 * Rss1;
Gammass1 = chibss1 + chigss1*sgss1-nuss1*psi/2*(sgss1-sbarg)^2;
Css1 = Yss1 - Igss1 - Ibss1 - Zss1 - psi/2*(sgss1 - sbarg)^2*Wss1;


tauess2 = 0.0399258;
Ass2 = 1;
taubss2 = 0.0000000001;
taugss2 = 0.0000000001;
Ygss2 =    0.780844552600502    ;
Ybss2 = 0.619845786216604 ;
Yss2 = (paib^(1/rhoY)*Ybss2^((rhoY-1)/rhoY)+(1-paib)^(1/rhoY)*Ygss2^((rhoY-1)/rhoY))^(rhoY/(rhoY-1));
pbss2 = (paib*Yss2/Ybss2)^(1/rhoY);
pgss2 = ((1-paib)*Yss2/Ygss2)^(1/rhoY);
muss2 = (tauess2*Ybss2^(epsilon-1)/theta1/theta2)^(1/(theta2-1));
Zss2 = theta1*muss2^theta2*Ybss2;
ess2 = (1-muss2)*Ybss2^epsilon;
Xss2 = (ess2 + erow)/(1-deltaX);
value1 = (1-alphab)*Ybss2*(pbss2-theta1*muss2^theta2-tauess2*(1-muss2)*epsilon*Ybss2^(epsilon-1));
value2 = (1-alphag)*pgss2*Ygss2;


Lbss2 = (value1/omegabar)^(1/(1+rhoL));
Lgss2 = (value2/omegabar)^(1/(1+rhoL));
Lss2 = (Lbss2^(1+rhoL)+Lgss2^(1+rhoL))^(1/(1+rhoL));
wbss2 = omegabar*Lbss2^rhoL;
wgss2 = omegabar * Lgss2^rhoL;
%d1 = d1/(Xss2/2030);
%d2 = d2/(Xss2/2030)^2;


Kgss2 = (Ygss2/Ass2/(1-d0-d1*Xss2-d2*Xss2^2)/Lgss2^(1-alphag))^(1/alphag);
Kbss2 = (Ybss2/Ass2/(1-d0-d1*Xss2-d2*Xss2^2)*Lbss2^(alphab-1))^(1/alphab);
%Kgss2 = (Ygss2/Ass2/(1-0.052)/Lgss2^(1-alphag))^(1/alphag);
%Kbss2 = (Ybss2/Ass2/(1-0.052)*Lbss2^(alphab-1))^(1/alphab);
Qgss2 = 1;
Qbss2 = 1;

Rkbss2 = (alphab*Ybss2/Kbss2*(pbss2-theta1*muss2^theta2-tauess2*(1-muss2)*epsilon*Ybss2^(epsilon-1))+(1-deltab)*Qbss2)/Qbss2;
Rkgss2 = (alphag*pgss2*Ygss2/Kgss2+(1-deltag)*Qgss2)/Qgss2;
Igss2 = Kgss2*deltag;
Ibss2 = Kbss2*deltab;
Sbss2 = Kbss2;
Sgss2 = Kgss2;

Mss2 = beta;
Rss2 = 1/Mss2;

Wss2 = Qbss2*Sbss2 + Qgss2*Sgss2;
sgss2 = Qgss2*Sgss2/Wss2;

Dss2 = ((1+taubss2)*Qbss2*Sbss2 + (1+taugss2)*Qgss2*Sgss2+psi/2*(sgss2-sbarg)^2*Wss2-gamma*(Rkgss2*Qgss2*Sgss2+Rkbss2*Qbss2*Sbss2)-zeta*(Qgss2*Sgss2+Qbss2*Sbss2))/(1-gamma*Rss2);
Nss2 = gamma*(Rkgss2*Qgss2*Sgss2+Rkbss2*Qbss2*Sbss2-Rss2*Dss2)+zeta*(Qgss2*Sgss2+Qbss2*Sbss2);
%Nss2 = 3.276;
phiss2 = kappa*Wss2/Nss2;
Omegass2 = Mss2*(1-gamma+gamma*phiss2);
%Omegass2 = Mss2*(1-gamma+gamma/beta*phiss2);
chibss2 = Omegass2*(Rkbss2-(1+taubss2)*Rss2);
chigss2 = Omegass2*((Rkgss2-Rkbss2)-(taugss2-taubss2)*Rss2);
nuss2 = Omegass2 * Rss2;
Gammass2 = chibss2 + chigss2*sgss2-nuss2*psi/2*(sgss2-sbarg)^2;
Css2 = Yss2 - Igss2 - Ibss2 - Zss2 - psi/2*(sgss2 - sbarg)^2*Wss2;

//************************模型******************



model;
L = (Lb^(1+rhoL)+Lg^(1+rhoL))^(1/(1+rhoL)); //equation1
M = beta*(C-omegabar*L^(1+xi)/(1+xi))^(-eta)/(C(-1)-omegabar*L(-1)^(1+xi)/(1+xi))^(-eta);//equation2
%M = beta*(C(+1)-omegabar*L(+1)^(1+xi)/(1+xi))^(-eta)/(C-omegabar*L^(1+xi)/(1+xi))^(-eta);//equation2
1=M(+1)*R;//equation3
wg = omegabar*Lg^rhoL;//equation4
wb = omegabar*Lb^rhoL;//equation5
W = Qb*Sb+Qg*Sg;//equation6
sg = Qg*Sg/W;//equation7
chib = Omega*(Rkb(+1)-(1+taub)*R);//equation8
chig = Omega*((Rkg(+1)-Rkb(+1))-(taug-taub)*R);//equation9
nu = Omega*R;//equation10
Omega=M(+1)*(1-gamma+gamma*phi(+1));//equation11
Gamma = chib + chig*sg - nu * psi/2*(sg - sbarg)^2;//equation12
phi = kappa * nu /(kappa - Gamma );//equation13
W = nu*N/(kappa-Gamma);//equation14
sg = chig / nu / psi + sbarg;//equation15
%N(+1) = gamma*(Rkg(+1)*Qg*Sg+Rkb(+1)*Qb*Sb-R*D)+zeta*(Qg*Sg+Qb*Sb);//equation16
N = gamma*(Rkg*Qg(-1)*Sg(-1)+Rkb*Qb(-1)*Sb(-1)-R(-1)*D(-1))+zeta*(Qg(-1)*Sg(-1)+Qb(-1)*Sb(-1));//equation16
D = (1+taub)*Qb*Sb+(1+taug)*Qg*Sg+psi/2*(sg-sbarg)^2*W-N;//equation17
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
Rkb = (alphab*Yb/Kb(-1)*(pb-theta1*mu^theta2-taue*(1-mu)*epsilon*Yb^(epsilon-1))+(1-deltab)*Qb)/Qb(-1);//equation28
wg = (1-alphag)*pg*Yg/Lg;//equation29
Rkg = (alphag*pg*Yg/Kg(-1) + (1-deltag)*Qg)/Qg(-1);//equation30
Qg = 1 + phig/2*(Ig/Ig(-1)-1)^2+phig*(Ig/Ig(-1)-1)*Ig/Ig(-1)-M(+1)*phig*(Ig(+1)/Ig-1)*(Ig(+1)/Ig)^2;//equation31
Qb = 1 + phib/2*(Ib/Ib(-1)-1)^2+phib*(Ib/Ib(-1)-1)*Ib/Ib(-1)-M(+1)*phib*(Ib(+1)/Ib-1)*(Ib(+1)/Ib)^2;//equation32
Kg = (1-deltag)*Kg(-1)+Ig;//equation33
Kb = (1-deltab)*Kb(-1)+Ib;//equation34
Qg*Sg=Qg*Kg;//equation35
Qb*Sb=Qb*Kb;//equation36
Y=C+Ig+Ib+Z+phig/2*(Ig/Ig(-1)-1)^2*Ig+phib/2*(Ib/Ib(-1)-1)^2*Ib+psi/2*(sg-sbarg)^2*W;//equation37

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
Sg=Sgss1;
Sb=Sbss1;
wg=wgss1;
wb=wbss1;
Rkg=Rkgss1;
Rkb=Rkbss1;
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
N=Nss1;
W=Wss1;
sg=sgss1;
D=Dss1;
R=Rss1;
 
chig=chigss1;
chib=chibss1;
nu=nuss1;
phi=phiss1;
Gamma=Gammass1;
Omega=Omegass1;

taub = taubss1;
taug = taugss1;
A = Ass1;
taue = tauess1;
end;
resid;
steady;
check(qz_zero_threshold=1e-200);

endval;
Lg=Lgss2;
Lb=Lbss2;
Kg=Kgss2;
Kb=Kbss2;
Ig=Igss2;
Ib=Ibss2;
Yg=Ygss2;
Yb=Ybss2;
Sg=Sgss2;
Sb=Sbss2;
wg=wgss2;
wb=wbss2;
Rkg=Rkgss2;
Rkb=Rkbss2;
Qg=Qgss2;
Qb=Qbss2;
pg=pgss2;
pb=pbss2;
C = Css2;
M=Mss2;
L=Lss2;
Y=Yss2;
Z=Zss2;
mu=muss2;
e=ess2;
X=Xss2;
N=Nss2;
W=Wss2;
sg=sgss2;
D=Dss2;
R=Rss2;
 
chig=chigss2;
chib=chibss2;
nu=nuss2;
phi=phiss2;
Gamma=Gammass2;
Omega=Omegass2;

taub = taubss2;
taug = taugss2;
A = Ass2;
taue = tauess2;
end;
resid;
steady(solve_algo=3);
check;

perfect_foresight_setup(periods=300);
perfect_foresight_solver;

moni.oo_ = oo_;
moni.M_  = M_;
moni = moni;

// -------------------------------------------------------------------------------------- //
//  COMPUTE PERCENTAGE CHANGES OF KEY VARIABLES (AS A SHARE OF INITIAL STUSDY STATE GDP)  //
// -------------------------------------------------------------------------------------- //
//CH variables
moni.Y          = (Y/Yss1-1)*100;
moni.Kb          = (Kb/Kbss1-1)*100;
moni.Kg          = (Kg/Kgss1-1)*100;

moni.I         = ((Ig+Ib)/(Igss1+Ibss1)-1)*100;

moni.e          = (e/ess1-1)*100;
moni.N          = (N/Nss1-1)*100;
moni.L = (L/Lss1-1)*100;
moni.Yg = (Yg/Ygss1-1)*100;
moni.Yb = (Yb/Ybss1-1)*100;
moni.Qg = (Qg/Qgss1-1)*100;
moni.Qb = (Qb/Qbss1-1)*100;

moni.pg = (pg/pgss1-1)*100;
moni.pb = (pb/pbss1-1)*100;
moni.W = (W/Wss1-1)*100;
moni.C = (C/Css1-1)*100;




