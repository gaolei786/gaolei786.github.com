function F = myfun0616( x )

Ygss = x(1);
Ybss = x(2);
%beta=0.995;
beta=0.99;%��С������Х��2016��		�����͹�����(2014)	�����ºͼ�Ң��2019��
eta = 2;%���ºͳ���¶(2014)	���ᳬ�ͷ��⣨2016��		½�ڣ�2020��
xi = 1;%���ºͳ���¶(2014)	���ᳬ�ͷ��⣨2016��		½�ڣ�2020��
%omegabar = 8.3849;
rhoL = 1;
%alphab = 0.35;
%alphag = 0.33;
alphab = 0.35;%������ͨ��ȡֵ1/3�����ҹ��ʱ�������ݶ�����ռ������Խϸ�	½�ڣ�2020��
alphag = 0.33;
deltab = 0.025;%��С������Х��2016��		���ºͳ���¶(2014)	���ᳬ�ͷ��⣨2016��
deltag = 0.025;%��С������Х��2016��		���ºͳ���¶(2014)	���ᳬ�ͷ��⣨2016��
phig = 10;%½�ڣ�2020��
phib = 10;%½�ڣ�2020��
%rhoA = 0.95;
rhoA = 0.8;%��־��ȣ�2019��			��־�����ԴԴ��2016��
%sigmaA = 0.007;
sigmaA =0.0246 ; %	�����պ��챣����2015��
%theta1 = 0.0335;
theta2 = 2.6;
d0 = -0.0076;
d1 = 8.1*10^(-6);
d2 = 1.05*10^(-8);
%d1 = 1.522550102017574*10^(-5);
%d2 =  3.709902078663939*10^(-8);
%deltaX = 0.9965;
deltaX = 0.9917; %Nordhaus��1991����Reily��1992����Falk��Mendelsohn��1993����Moore��Braswell��1994����Angelopoulos��2013����Annicchiarico��2015�����ҹ�ʵ��	����̩��2017��
%epsilon = 1;
epsilon = 0.843754;%ʢ���루2016��		����1995-2014���ʡ���̼�ŷ�����GDP����

%erow = 3.1499;
rhoY = 2;
%paib = 0.3326;
paib = x(3);

% kappa = 0.3409;
kappa = x(4);
gamma = 0.972;
% zeta = 0.003;
zeta = x(5);
psi = 0.0001;
% sbarg = 0.6;

tauess = 0;
Ass = 1;
taubss = 0;
taugss = 0;


Yss = (paib^(1/rhoY)*Ybss^((rhoY-1)/rhoY)+(1-paib)^(1/rhoY)*Ygss^((rhoY-1)/rhoY))^(rhoY/(rhoY-1));
pbss = (paib*Yss/Ybss)^(1/rhoY);
pgss = ((1-paib)*Yss/Ygss)^(1/rhoY);
theta1 = 0.015*Yss/Ybss;
muss = (tauess*Ybss^(epsilon-1)/theta1/theta2)^(1/(theta2-1));
Zss = theta1*muss^theta2*Ybss;
ess = (1-muss)*Ybss^epsilon;
erow = 2.47*ess;
Xss = (ess + erow)/(1-deltaX);
value1 = (1-alphab)*Ybss*(pbss-theta1*muss^theta2-tauess*(1-muss)*epsilon*Ybss^(epsilon-1));
value2 = (1-alphag)*pgss*Ygss;

omegabar = 3^(1+rhoL)*(value1+value2);
Lbss = (value1/omegabar)^(1/(1+rhoL));
Lgss = (value2/omegabar)^(1/(1+rhoL));
%Lss = (Lbss^(1+rhoL)+Lgss^(1+rhoL))^(1/(1+rhoL));
% Lss = 1/3;
Lss = 1;
wbss = omegabar*Lbss^rhoL;
wgss = omegabar * Lgss^rhoL;
d1 = d1/(Xss/2095);
d2 = d2/(Xss/2095)^2;


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
sbarg = sgss;

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
F3 = Kgss/(Kgss+Kbss)-0.6;
%F4 = Wss/Nss-4.5;
F4 = Wss/Nss-4.43;%˾�ǿ�2019
F5 = Rkgss^4 - Rss^4 - 0.0143;
F = [F1;F2;F3;F4;F5];
% F = [F1;F2;F3];
end

