close all;
dynare chengxu.mod;
dynare chengxu4.mod;
%dynare chengxu5.mod;


moni = moni;
moni1 = moni4;
moni2 = moni;

horizon=20;
figure
plot([1:1:21]', moni.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;
set(gca,'FontSize',20);
xlim([0 22])
 %set(gca,'position',[.05  .05  .90  .88])
title('�ܲ���','FontSize',15)



horizon=20;
figure
plot([1:1:21]', moni.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20); 
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ�ʱ�','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ�ʱ�','FontSize',15)




horizon=20;
figure
plot([1:1:21]', moni.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20); 
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��Ͷ��','FontSize',15)


horizon=20;
figure
plot([1:1:21]', moni.e(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.e(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.e(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20); 
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('̼�ŷ�','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20); 
xlim([0 22]) 
ylim([-25 0])
%set(gca,'position',[.05  .05  .90  .88])
title('���о�ֵ','FontSize',15)



horizon=20;
figure
plot([1:1:21]', moni.L(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.L(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.L(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('�ܾ�ҵ','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ���Ų���','FontSize',15)


horizon=20;
figure
plot([1:1:21]', moni.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ���Ų���','FontSize',15)


horizon=20;
figure
plot([1:1:21]', moni.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
legend( {'ͻȻʵʩ̼˰','����ʵʩ̼˰',},'FontSize',15,'Location','SouthEast')
legend('boxoff','Location','SouthEast') 
title('��ɫ�ʲ��۸�','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ�ʲ��۸�','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.pg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.pg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.pg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ��Ʒ�۸�','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.pb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.pb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.pb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ��Ʒ�۸�','FontSize',15)

horizon=20;
figure
tanshui = [0 0.00199629 0.00399258 0.00598887 0.00798516 0.00998145 0.01197774 0.01397403 0.01597032 0.01796661 0.01996290 0.02195919 0.02395548 0.02595177 0.02794806 0.02994435 0.03194064 0.03393693 0.03593322 0.03792951 0.03992580]*198/0.03992580;
plot([1:1:21]', [0 repelem(198.8,20)],'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]',tanshui,'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
ylim([0 210])
set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('̼˰��Ԫ/��)','FontSize',15)


horizon=20;
figure
plot([1:1:21]', moni.W(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.W(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni.W(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('���д���','FontSize',15)

horizon=20;
figure
plot([1:1:21]', moni.C(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni1.C(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',2, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.C(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',2, 'Color',[0 0 0] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('����','FontSize',15)
 biaoti = [string('1Aggregate output'), string('1Brown Capital'),string('1Green capital'),string('1Aggregate investment'),string('1emissions'),string('1Bank net worth '),...
     string('1Aggregate labor'),string('1Green Production'),string('1Brown production'),string('1price of brown assets'),string('1price of green assets'),string('1price of green products'),string('1price of brown products'),string('1emmision tax'),string('1bank credit'),string('1consumption');]
for i=1:16
    print(i,'-dpng',strcat( char(biaoti(1,i)), '.png'));
end

(moni.C(20)+moni1.C(20))/2

(moni.L(20)+moni1.L(20))/2

moni.Qb(1:3)
moni.N(1:3)
moni1.W(1:3)

