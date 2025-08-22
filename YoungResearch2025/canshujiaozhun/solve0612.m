%利用myfun函数求解x
fun1 = @myfun0612;
options = optimset('Maxfuneval',50000, 'MaxIter', 5000, 'TolFun',1e-30);
%[x] = fsolve(fun1, [0.5466,0.4926,0.7093,0.6501,0.0101],options )
[x] = fsolve(fun1, [ 0.4161, 0.6356 ,0.5422, 0.8426, 0.0069, 0.4402, 0.0013,  0.7035],options )
%[x] = fsolve(fun1, [0.6, 0.5,0.7,0.6,0.017],options )
Cgss = x(1);
Cbss = x(2);
Ygss = x(3);
Ybss = x(4);
%tau_e =0.006950972307235;
tau_e =x(5);
%beta=0.9975;
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
d0 = -0.0076; %s
d1 = 1.731098840422208e-05; %s
d2 = 4.795821300223547e-08; %s
rho_c = 2; %s
%kappa = 0.337388881860543  ;
kappa = x(6);  %s
gamma = 0.974;  %s
zeta = x(7);  %s
%zeta = 0.002284982884902 ;
%pi_b =  0.702469212147516; %before
pi_b = x(8);
tau_z = 0; %before
tau_b = 0; %before
tau_g = 0; %before
tau_gt = 0; %before

A=1 ; %before
kappa_b = 1; %before
kappa_g = 1; %before
Mss = beta ;
Rss = 1/Mss ;

Css = ((pi_b^(1/rho_c)*Cbss^((rho_c-1)/rho_c) + ((1-pi_b)^(1/rho_c)*Cgss^((rho_c-1)/rho_c))))^(rho_c/(rho_c-1));%B.15
p_bss = ((pi_b * Css) / Cbss)^(1/rho_c);%B.16
p_gss = (( (1-pi_b) *Css ) / Cgss )^(1/rho_c);%B.17
muss = ((1-tau_z)*p_bss*theta1*theta2/(tau_e))^(-1/(theta2-1)); %B.22
value1 = ((1-alpha_b)*(p_bss - (1-tau_z)*p_bss*theta1*(muss^theta2) - tau_e*(1-muss))); %B.21
value2 = ((1-alpha_g)*p_gss*(1+tau_gt)); %B.24
varho = 9*(value1*Ybss)+9*(value2*Ygss);
Lbss = (Ybss*value1/varho)^(1/2);
Lgss = (Ygss*value2/varho)^(1/2);
e_bss = (1-muss)*Ybss;%B.19
erowss = e_bss*2;
Xss = (e_bss + erowss )/(1-delta_X);%B18
%d1n = d1/(Xss/2095);
%d2n = d2/(Xss/2095)^2;
dss = d0 + d1*Xss + d2*(Xss^2);
Zbss = (1-tau_z)*theta1*(muss^theta2)*(Ybss);%B.20
w_bss = varho*Lbss^rho_L;%B.4
w_gss = varho * Lgss;%B.4
Kbss= ((1-dss)*A*(Lbss^(1-alpha_b))/(Ybss))^(-1/alpha_b); %B.14
Kgss= ((1-dss)*A*(Lgss^(1-alpha_g))/(Ygss))^(-1/alpha_g); %B.14
Qbss = p_bss; %B.26
Qgss = p_gss; %B.26
Rbss = (alpha_b*(Ybss/Kbss) * (p_bss - (1-tau_z)*p_bss*theta1*muss^(theta2)-tau_e*(1-muss ) ) + (1-delta_b)*Qbss ) / Qbss;%B.23
Rgss = alpha_g*(1+tau_gt)*Ygss/Kgss + (1-delta_g); %B.25
Lss = (Lbss^(1+rho_L) + Lgss^(1+rho_L))^(1/(1+rho_L)); %B.1
Yss = p_bss*Ybss + p_gss*Ygss;%B.30
Ibss = delta_b*Kbss;
Igss = delta_g*Kgss;
Iss = p_bss*Ibss + p_gss*Igss;%B.31
Sbss = Kbss;
Sgss = Kgss;
Dss = ((1+tau_b)*Qbss*Sbss + (1+tau_g)*Qgss*Sgss-gamma*(Rgss*Qgss*Sgss+Rbss*Qbss*Sbss)-zeta*(Qgss*Sgss+Qbss*Sbss))/(1-gamma*Rss); %B.12
Nss = gamma*(Rgss*Qgss*Sgss+Rbss*Qbss*Sbss-Rss*Dss)+zeta*(Qgss*Sgss+Qbss*Sbss); %B.11
phiss = kappa*( kappa_b*Qbss*Sbss + kappa_g*Qgss*Sgss )/Nss; %B.13
Omegass = Mss*(1-gamma + gamma* phiss); %B.7
chi_bss =  Omegass*(Rbss- (1+tau_b)*Rss) ; %B.5
chi_gss =  Omegass*(Rgss- (1+tau_g)*Rss) ; %B.6
nuss =  Omegass * Rss ; %B.8



% 残差方程1：B.9
F1 = chi_bss / kappa_b - chi_gss / kappa_g;  

% 残差方程2：B.10
F2 = phiss- kappa*kappa_b*nuss/(kappa_b*kappa-chi_bss) ;

% 残差方程3：B.28
F3 = Ybss - Ibss-Cbss-Zbss ; %B.28

% 残差方程4：B.29
F4 = Ygss - Cgss-Igss;
%F5 = e_bss*tau_e/Yss-0.0034;
F5 = e_bss*tau_e/Yss-126*91.8/1349084*0.4; %用于求tau_e

F6 = (Qbss*Sbss + Qgss*Sgss )/Nss-4.43; %用于求kappa
F7 = Rgss^4 - Rss^4 - 0.0081; %2024年发行3年期绿色债券平均发行利率4.37%，3年期国债1.19%，用于求zeta
F8 = Cgss/Css-0.4;

F = [F1;F2;F3;F4;F5;F6;F7;F8];
d1n
d2n
e_bss
erowss
(Qbss*Sbss)/(Qbss*Sbss + Qgss*Sgss )