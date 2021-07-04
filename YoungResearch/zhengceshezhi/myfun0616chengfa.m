function F = myfun0616chengfa( x )



Ygss = x(1);
Ybss = x(2);
taubss = x(3);
taugss = 0;
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
sigmaA =0.0246  %	黄赜琳和朱保华（2015）
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


tauess = 0.00000001;
Ass = 1;
% taubss = 0.00000001;
% taugss = 0.00000001;

Yss = (paib^(1/rhoY)*Ybss^((rhoY-1)/rhoY)+(1-paib)^(1/rhoY)*Ygss^((rhoY-1)/rhoY))^(rhoY/(rhoY-1));
%Yss = (paib^(1/rhoY)*Ybss^((rhoY-1)/rhoY)+(1-paib)^(1/rhoY)*Ygss^((rhoY-1)/rhoY))^(rhoY/(rhoY-1));
pbss = (paib*Yss/Ybss)^(1/rhoY);
pgss = ((1-paib)*Yss/Ygss)^(1/rhoY);
muss = (tauess*Ybss^(epsilon-1)/theta1/theta2)^(1/(theta2-1));
Zss = theta1*muss^theta2*Ybss;
ess = (1-muss)*Ybss^epsilon;
Xss = (ess + erow)/(1-deltaX);
value1 = (1-alphab)*Ybss*(pbss-theta1*muss^theta2-tauess*(1-muss)*epsilon*Ybss^(epsilon-1));
value2 = (1-alphag)*pgss*Ygss;


Lbss = (value1/omegabar)^(1/(1+rhoL));
Lgss = (value2/omegabar)^(1/(1+rhoL));
Lss = (Lbss^(1+rhoL)+Lgss^(1+rhoL))^(1/(1+rhoL));
wbss = omegabar*Lbss^rhoL;
wgss = omegabar * Lgss^rhoL;
%d1 = d1/(Xss/2030);
%d2 = d2/(Xss/2030)^2;


Kgss = (Ygss/Ass/(1-d0-d1*Xss-d2*Xss^2)/Lgss^(1-alphag))^(1/alphag);
Kbss = (Ybss/Ass/(1-d0-d1*Xss-d2*Xss^2)*Lbss^(alphab-1))^(1/alphab);
%Kgss = (Ygss/Ass/(1-0.052)/Lgss^(1-alphag))^(1/alphag);
%Kbss = (Ybss/Ass/(1-0.052)*Lbss^(alphab-1))^(1/alphab);
Qgss = 1;
Qbss = 1;

Rkbss = (alphab*Ybss/Kbss*(pbss-theta1*muss^theta2-tauess*(1-muss)*epsilon*Ybss^(epsilon-1))+(1-deltab)*Qbss)/Qbss;
Rkgss = (alphag*pgss*Ygss/Kgss+(1-deltag)*Qgss)/Qgss;
Igss = Kgss*deltag;
Ibss = Kbss*deltab;
Sbss = Kbss;
Sgss = Kgss;

Mss = beta;
Rss = 1/Mss;

Wss = Qbss*Sbss + Qgss*Sgss;
sgss = Qgss*Sgss/Wss;

Dss = ((1+taubss)*Qbss*Sbss + (1+taugss)*Qgss*Sgss+psi/2*(sgss-sbarg)^2*Wss-gamma*(Rkgss*Qgss*Sgss+Rkbss*Qbss*Sbss)-zeta*(Qgss*Sgss+Qbss*Sbss))/(1-gamma*Rss);
Nss = gamma*(Rkgss*Qgss*Sgss+Rkbss*Qbss*Sbss-Rss*Dss)+zeta*(Qgss*Sgss+Qbss*Sbss);
phiss = kappa*Wss/Nss;
Omegass = Mss*(1-gamma+gamma*phiss);
%Omegass = Mss*(1-gamma+gamma/beta*phiss);
chibss = Omegass*(Rkbss-(1+taubss)*Rss);
chigss = Omegass*((Rkgss-Rkbss)-(taugss-taubss)*Rss);
nuss = Omegass * Rss;
Gammass = chibss + chigss*sgss-nuss*psi/2*(sgss-sbarg)^2;
Css = Yss - Igss - Ibss - Zss - psi/2*(sgss - sbarg)^2*Wss;

F1 = phiss-kappa*nuss/(kappa-Gammass);
F2 = sgss - (chigss/nuss/psi+sbarg);
F3 = sgss - 0.7;
F = [F1;F2;F3];
end

