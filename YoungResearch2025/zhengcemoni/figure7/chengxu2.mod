//*****************内生变量定义***********************************
var
Cg Cb Yg Yb M R C p_b p_g
mu Lg Lb e_b X d Zb w_b w_g
Kb Kg Qb Qg Rb Rg L Y Ig Ib
I Sb Sg D N phi chi_b chi_g nu Omega
;

//*****************外生变量定义***********************************
varexo
tau_b tau_e tau_g   A pi_b
;
//*****************参数定义******************************
parameters
beta eta xi varho rho_L  alpha_b alpha_g delta_g delta_b rho_A phi_b
phi_g sigma_A theta1 theta2 delta_X erow d0 d1 d2 rho_c
kappa kappa_b kappa_g gamma zeta  tau_z tau_gt

Cbss1 Cgss1 Ygss1 Ybss1 Mss1 Rss1 Css1 p_bss1 p_gss1
muss1 Lgss1 Lbss1 e_bss1 Xss1 dss1 Zbss1 w_bss1 w_gss1
Kbss1 Kgss1 Qbss1 Qgss1 Rbss1 Rgss1 Lss1 Yss1 Igss1 Ibss1
Iss1 Sbss1 Sgss1 Dss1 Nss1 phiss1 chi_bss1 chi_gss1 nuss1

Cgss2 Cbss2 Ygss2 Ybss2 Mss2 Rss2 Css2 p_bss2 p_gss2
muss2 Lgss2 Lbss2 e_bss2 Xss2 dss2 Zbss2 w_bss2 w_gss2
Kbss2 Kgss2 Qbss2 Qgss2 Rbss2 Rgss2 Lss2 Yss2 Igss2 Ibss2
Iss2 Sbss2 Sgss2 Dss2 Nss2 phiss2 chi_bss2 chi_gss2 nuss2
;


%校准值
%predetermined_variables M;
%beta=0.995;
beta=0.9925;%陈小亮和马啸（2016）		康立和龚六堂(2014)	王立勇和纪尧（2019）
eta = 2;%马勇和陈雨露(2014)	彭俞超和方意（2016）		陆磊（2020）
xi = 1;%马勇和陈雨露(2014)	彭俞超和方意（2016）		陆磊（2020）


varho = 8.1908; %s
rho_L = 1; %s
alpha_b = 0.35; %s
alpha_g = 0.33; %s
delta_b = 0.025; %s
delta_g = 0.025; %s
rho_A = 0.9; %s
phi_b = 10; %s
phi_g = 10; %s
sigma_A = 0.01; %s
theta1 = 0.0335; %s
theta2 = 2.6; %s
delta_X = 0.9979; %s
erow = 1.3724; %s
d0 = -0.0076; %s
d1 = 1.7311e-05; %s
d2 = 4.7958e-08; %s
rho_c = 2; %s
kappa = 0.3374;  %s
gamma = 0.974;  %s
zeta = 0.0023;  %s
kappa_b = 1; %before
kappa_g = 1; %before
tau_gt = 0.00000000000001;
tau_z =0.00000000000001;

pi_bss1 = 0.7025;
tau_ess1 = 0.007;
Ass1 = 1;
tau_bss1 = 0.00000000000001;
tau_gss1 = 0.00000000000001;
Ygss1 =   0.549792546459198    ;
Ybss1 =  0.854687883787628 ;
Cgss1 = 0.418437093115286;
Cbss1 = 0.638924981821951;


Mss1 = beta ;
Rss1 = 1/Mss1 ;
Css1 = ((pi_bss1^(1/rho_c)*Cbss1^((rho_c-1)/rho_c) + ((1-pi_bss1)^(1/rho_c)*Cgss1^((rho_c-1)/rho_c))))^(rho_c/(rho_c-1));%B.15
p_bss1 = ((pi_bss1 * Css1) / Cbss1)^(1/rho_c);%B.16
p_gss1 = (( (1-pi_bss1) *Css1 ) / Cgss1 )^(1/rho_c);%B.17
muss1 = ((1-tau_z)*p_bss1*theta1*theta2/(tau_ess1))^(-1/(theta2-1)); %B.22
value1 = varho/((1-alpha_b)*(p_bss1 - (1-tau_z)*p_bss1*theta1*(muss1^theta2) - tau_ess1*(1-muss1))); %B.21
value2 = varho/((1-alpha_g)*p_gss1*(1+tau_gt)); %B.24
Lbss1 = (Ybss1/value1)^(1/2);
Lgss1 = (Ygss1/value2)^(1/2);
e_bss1 = (1-muss1)*Ybss1;%B.19
Xss1 = ( e_bss1 + erow )/(1-delta_X);%B18
dss1 = d0 + d1*Xss1 + d2*(Xss1^2);
Zbss1 = (1-tau_z)*theta1*(muss1^theta2)*(Ybss1);%B.20
w_bss1 = varho*Lbss1^rho_L;%B.4
w_gss1 = varho * Lgss1;%B.4
Kbss1= ((1-dss1)*Ass1*(Lbss1^(1-alpha_b))/(Ybss1))^(-1/alpha_b); %B.14
Kgss1= ((1-dss1)*Ass1*(Lgss1^(1-alpha_g))/(Ygss1))^(-1/alpha_g); %B.14
Qbss1 = p_bss1; %B.26
Qgss1 = p_gss1; %B.26
Rbss1 = (alpha_b*(Ybss1/Kbss1) * (p_bss1 - (1-tau_z)*p_bss1*theta1*muss1^(theta2)-tau_ess1*(1-muss1 ) ) + (1-delta_b)*Qbss1 ) / Qbss1;%B.23
Rgss1 = alpha_g*(1+tau_gt)*Ygss1/Kgss1 + (1-delta_g); %B.25
Lss1 = (Lbss1^(1+rho_L) + Lgss1^(1+rho_L))^(1/(1+rho_L)); %B.1
Yss1 = p_bss1*Ybss1 + p_gss1*Ygss1;%B.30
Ibss1 = delta_b*Kbss1;
Igss1 = delta_g*Kgss1;
Iss1 = p_bss1*Ibss1 + p_gss1*Igss1;%B.31
Sbss1 = Kbss1;
Sgss1 = Kgss1;
Dss1 = ((1+tau_bss1)*Qbss1*Sbss1 + (1+tau_gss1)*Qgss1*Sgss1-gamma*(Rgss1*Qgss1*Sgss1+Rbss1*Qbss1*Sbss1)-zeta*(Qgss1*Sgss1+Qbss1*Sbss1))/(1-gamma*Rss1); %B.12
Nss1 = gamma*(Rgss1*Qgss1*Sgss1+Rbss1*Qbss1*Sbss1-Rss1*Dss1)+zeta*(Qgss1*Sgss1+Qbss1*Sbss1); %B.11
phiss1 = kappa*( kappa_b*Qbss1*Sbss1 + kappa_g*Qgss1*Sgss1 )/Nss1; %B.13
Omegass1 = Mss1*(1-gamma + gamma* phiss1); %B.7
chi_bss1 =  Omegass1*(Rbss1- (1+tau_bss1)*Rss1) ; %B.5
chi_gss1 =  Omegass1*(Rgss1- (1+tau_gss1)*Rss1) ; %B.6
nuss1 =  Omegass1 * Rss1 ; %B.8


pi_bss2 =0.5052; %before
tau_ess2 = 0.007;
Ass2 = 1;
tau_bss2 = 0.00000000000001;
tau_gss2 = 0.00000000000001;
Ygss2 = 0.665453201171861;
Ybss2 = 0.781836141921535;
Cgss2 = 0.506441793542606;
Cbss2 =0.584478907996560;


Mss2 = beta ;
Rss2 = 1/Mss2 ;
Css2 = ((pi_bss2^(1/rho_c)*Cbss2^((rho_c-1)/rho_c) + ((1-pi_bss2)^(1/rho_c)*Cgss2^((rho_c-1)/rho_c))))^(rho_c/(rho_c-1));%B.15
p_bss2 = ((pi_bss2 * Css2) / Cbss2)^(1/rho_c);%B.16
p_gss2 = (( (1-pi_bss2) *Css2 ) / Cgss2 )^(1/rho_c);%B.17
muss2 = ((1-tau_z)*p_bss2*theta1*theta2/(tau_ess2))^(-1/(theta2-1)); %B.22
value1 = varho/((1-alpha_b)*(p_bss2 - (1-tau_z)*p_bss2*theta1*(muss2^theta2) - tau_ess2*(1-muss2))); %B.21
value2 = varho/((1-alpha_g)*p_gss2*(1+tau_gt)); %B.24
Lbss2 = (Ybss2/value1)^(1/2);
Lgss2 = (Ygss2/value2)^(1/2);
e_bss2 = (1-muss2)*Ybss2;%B.19
Xss2 = ( e_bss2 + erow )/(1-delta_X);%B18

dss2 = d0 + d1*Xss2 + d2*(Xss2^2);
Zbss2 = (1-tau_z)*theta1*(muss2^theta2)*(Ybss2);%B.20
w_bss2 = varho*Lbss2^rho_L;%B.4
w_gss2 = varho * Lgss2;%B.4
Kbss2= ((1-dss2)*Ass2*(Lbss2^(1-alpha_b))/(Ybss2))^(-1/alpha_b); %B.14
Kgss2= ((1-dss2)*Ass2*(Lgss2^(1-alpha_g))/(Ygss2))^(-1/alpha_g); %B.14
Qbss2 = p_bss2; %B.26
Qgss2 = p_gss2; %B.26
Rbss2 = (alpha_b*(Ybss2/Kbss2) * (p_bss2 - (1-tau_z)*p_bss2*theta1*muss2^(theta2)-tau_ess2*(1-muss2 ) ) + (1-delta_b)*Qbss2 ) / Qbss2;%B.23
Rgss2 = alpha_g*(1+tau_gt)*Ygss2/Kgss2 + (1-delta_g); %B.25
Lss2 = (Lbss2^(1+rho_L) + Lgss2^(1+rho_L))^(1/(1+rho_L)); %B.1
Yss2 = p_bss2*Ybss2 + p_gss2*Ygss2;%B.30
Ibss2 = delta_b*Kbss2;
Igss2 = delta_g*Kgss2;
Iss2 = p_bss2*Ibss2 + p_gss2*Igss2;%B.31
Sbss2 = Kbss2;
Sgss2 = Kgss2;
Dss2 = ((1+tau_bss2)*Qbss2*Sbss2 + (1+tau_gss2)*Qgss2*Sgss2-gamma*(Rgss2*Qgss2*Sgss2+Rbss2*Qbss2*Sbss2)-zeta*(Qgss2*Sgss2+Qbss2*Sbss2))/(1-gamma*Rss2); %B.12
Nss2 = gamma*(Rgss2*Qgss2*Sgss2+Rbss2*Qbss2*Sbss2-Rss2*Dss2)+zeta*(Qgss2*Sgss2+Qbss2*Sbss2); %B.11
phiss2 = kappa*( kappa_b*Qbss2*Sbss2 + kappa_g*Qgss2*Sgss2 )/Nss2; %B.13
Omegass2= Mss2*(1-gamma + gamma* phiss2); %B.7
chi_bss2 =  Omegass2*(Rbss2- (1+tau_bss2)*Rss2) ; %B.5
chi_gss2 =  Omegass2*(Rgss2- (1+tau_gss2)*Rss2) ; %B.6
nuss2 =  Omegass2 * Rss2 ; %B.8

% //************************模型******************
model;
% 方程 (B.1)
L = (Lb^(1+rho_L)+Lg^(1+rho_L))^(1/(1+rho_L));

% 方程 (B.2)
M = beta*(C-varho*L^(1+xi)/(1+xi))^(-eta)/(C(-1)-varho*L(-1)^(1+xi)/(1+xi))^(-eta);

% 方程 (B.3)
1=M(+1)*R;

% equation4
w_g = varho*Lg^rho_L;
% equation5
w_b = varho*Lb^rho_L;

% 方程 (B.5)e6
chi_b = M(+1)*(1-gamma+gamma*phi(+1))*((alpha_b*Yb(+1)/(Kb) * (p_b(+1) - (1-tau_z)*p_b(+1)*theta1*mu(+1)^(theta2)-tau_e*(1-mu(+1) ) ) + (1-delta_b)*Qb(+1) ) / Qb-(1+tau_b)*R) ;

% 方程 (B.6)e7
chi_g = M(+1)*(1-gamma+gamma*phi(+1))*(( alpha_g*(1+tau_gt)*Yg(+1)/Kg*p_g + (1-delta_g)*Qg(+1)) / Qg-(1+tau_g)*R) ;

% 方程 (B.7)e8
Omega = M*(1-gamma+gamma*phi(+1));

% 方程 (B.8)e9
nu = M(+1)*(1-gamma+gamma*phi(+1))*R;

% 方程 (B.9)e10
chi_b / kappa_b = chi_g / kappa_g;

% 方程 (B.10)e11
phi = kappa*nu*kappa_b / (kappa*kappa_b - chi_b) ; 

% 方程 (B.11)e12
N = gamma*(Rg*Qg(-1)*Sg(-1)+Rb*Qb(-1)*Sb(-1)-R(-1)*D(-1))+zeta*(Qg(-1)*Sg(-1)+Qb(-1)*Sb(-1));


% 方程 (B.12)e13
D = (1+tau_b)*Qb*Sb + (1+tau_g)*Qg*Sg - N;

% 方程 (B.13)e14
kappa_b*Qb*Sb + kappa_g*Qg*Sg = nu*kappa_b / (kappa*kappa_b - chi_b)*N;

% 方程 (B.14)e15/e16
Yb = (1-d)*A*(Kb(-1)^alpha_b)*(Lb^(1-alpha_b));
Yg = (1-d)*A*(Kg(-1)^alpha_g)*(Lg^(1-alpha_g));

% 方程 (B.15)e17
C = ((pi_b^(1/rho_c)*Cb^((rho_c-1)/rho_c) + ((1-pi_b)^(1/rho_c)*Cg^((rho_c-1)/rho_c))))^(rho_c/(rho_c-1));

% 方程 (B.16)e18
p_b = ((pi_b * C) / Cb)^(1/rho_c);

% 方程 (B.17)e19
p_g = (( (1-pi_b) *C ) / Cg )^(1/rho_c);

% 方程 (B.18)e20
X = delta_X*X(-1) + e_b + erow;

% 方程 (B.19)e21
e_b = (1-mu)*Yb;

% 方程 (B.20)e22
Zb = (1-tau_z)*theta1*(mu^theta2)*(Yb);

% 方程 (B.21)e23
w_b = (1-alpha_b)*Yb/Lb*(p_b - (1-tau_z)*p_b*theta1*(mu^theta2) - tau_e*(1-mu)) ;

% 方程 (B.22)e24
tau_e = (1-tau_z)*p_b*theta1*theta2*(mu^(theta2-1));

% 方程 (B.23)e25
Rb = (alpha_b*Yb/(Kb(-1)) * (p_b - (1-tau_z)*p_b*theta1*mu^(theta2)-tau_e*(1-mu ) ) + (1-delta_b)*Qb ) / Qb(-1);

% 方程 (B.24)e26
w_g = (1-alpha_g)*(1+tau_gt)*Yg/Lg*p_g;

% 方程 (B.25)e27
Rg = ( alpha_g*(1+tau_gt)*Yg/Kg(-1)*p_g + (1-delta_g)*Qg ) / Qg(-1);

% 方程 (B.26)e28/e29
Qb = p_b*( 1+(phi_b)/2*(Ib/Ib(-1)-1)^2 + phi_b*(Ib/Ib(-1)-1)*(Ib/Ib(-1)) ) - ((M(+1)*p_b(+1)*phi_b*(Ib(+1)/Ib -1)*(Ib(+1)/Ib)^2 ) ) ;
Qg = p_g*( 1+(phi_g)/2*(Ig/Ig(-1)-1)^2 + phi_g*(Ig/Ig(-1)-1)*(Ig/Ig(-1)) ) - ((M(+1)*p_g(+1)*phi_g*(Ig(+1)/Ig -1)*(Ig(+1)/Ig)^2 ) ) ;

% 方程 (B.27)e30/e31
Kb = (1-delta_b)*Kb(-1) + Ib;
Kg = (1-delta_g)*Kg(-1) + Ig;

% 方程 (B.28)e32
Yb = Cb + Ib + Zb + phi_b*(1/2)*( (Ib/Ib(-1)-1)^2 )*Ib;

% 方程 (B.29)e33
Yg = Cg + Ig + phi_g*(1/2)*( (Ig/Ig(-1)-1)^2 )*Ig;

% 方程 (B.30)e34
Y = p_b*Yb + p_g*Yg;

% 方程 (B.31)e35
I = p_b*Ib + p_g*Ig;

% 方程 (B.32)e36
d = d0 + d1*X + d2*(X^2);

% 方程 (B.33)e37/e38
Sb = Kb;
Sg = Kg;

end;

initval;
Lg=Lgss1;
Lb=Lbss1;
L=Lss1;
Cb=Cbss1;
Cg=Cgss1;
Yg=Ygss1;
Yb=Ybss1;
M=Mss1;
R=Rss1;
C = Css1;
p_g=p_gss1;
p_b=p_bss1;
mu=muss1;
e_b=e_bss1;
X=Xss1;
d=dss1;
Zb=Zbss1;
w_g=w_gss1;
w_b=w_bss1;
Kg=Kgss1;
Kb=Kbss1;
Qg=Qgss1;
Qb=Qbss1;
Rg=Rgss1;
Rb=Rbss1;
Y=Yss1;
Ig=Igss1;
Ib=Ibss1;
Sg=Sgss1;
Sb=Sbss1;
I=Iss1;
D=Dss1;
phi=phiss1;

Omega=Omegass1;
N=Nss1;
chi_g=chi_gss1;
chi_b=chi_bss1;
nu=nuss1;


pi_b=pi_bss1;
tau_b = tau_bss1;
tau_g = tau_gss1;

A = Ass1;
tau_e = tau_ess1;
end;
resid;
steady;
check(qz_zero_threshold=1e-200);

endval;
Lg=Lgss2;
Lb=Lbss2;
L=Lss2;
Cb=Cbss2;
Cg=Cgss2;
Yg=Ygss2;
Yb=Ybss2;
M=Mss2;
R=Rss2;
C = Css2;
p_g=p_gss2;
p_b=p_bss2;
mu=muss2;
e_b=e_bss2;
X=Xss2;
d=dss2;
Zb=Zbss2;
w_g=w_gss2;
w_b=w_bss2;
Kg=Kgss2;
Kb=Kbss2;
Qg=Qgss2;
Qb=Qbss2;
Rg=Rgss2;
Rb=Rbss2;
Y=Yss2;
Ig=Igss2;
Ib=Ibss2;
Sg=Sgss2;
Sb=Sbss2;
I=Iss2;
D=Dss2;
phi=phiss2;

Omega=Omegass2;
N=Nss2;
chi_g=chi_gss2;
chi_b=chi_bss2;
nu=nuss2;


pi_b=pi_bss2;
tau_b = tau_bss2;
tau_g = tau_gss2;
A = Ass2;
tau_e = tau_ess2;
end;
resid;
steady(solve_algo=3);
check;

perfect_foresight_setup(periods=300);
perfect_foresight_solver;

moni.oo_ = oo_;
moni.M_  = M_;
moni = moni;



moni2.Y          = (Y/Y(1)-1)*100;
moni2.Yb          = (Yb/Yb(1)-1)*100;
moni2.Yg          = (Yg/Yg(1)-1)*100;
moni2.Kb          = (Kb/Kb(1)-1)*100;
moni2.Kg          = (Kg/Kg(1)-1)*100;
moni2.Qb          = (Qb/Qb(1)-1)*100;
moni2.Qg          = (Qg/Qg(1)-1)*100;
moni2.L         = (L/L(1)-1)*100;
moni2.I         = (I/I(1)-1)*100;
moni2.C         = (C/C(1)-1)*100;
moni2.e_b        = (e_b/e_b(1)-1)*100;
moni2.N          = (N/N(1)-1)*100;
moni2.p_g = (p_g/p_g(1)-1)*100;
moni2.p_b = (p_b/p_b(1)-1)*100;





