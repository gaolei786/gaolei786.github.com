close all;
dynare chengxu.mod;
dynare chengxu1.mod;



moni = moni;
moni1 = moni1;
moni2 = moni;


horizon=20;
figure
plot([1:1:21]', moni.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20);
xlim([0 22])
 %set(gca,'position',[.05  .05  .90  .88])
title('总产出','FontSize',22)



horizon=20;
figure
plot([1:1:21]', moni.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20); 
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('棕色资本','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('绿色资本','FontSize',22)




horizon=20;
figure
plot([1:1:21]', moni.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20); 
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('总投资','FontSize',22)


horizon=20;
figure
plot([1:1:21]', moni.e(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.e(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.e(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20); 
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('碳排放','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20); 
xlim([0 22]) 
ylim([-25 0])
%set(gca,'position',[.05  .05  .90  .88])
title('银行净值','FontSize',22)




horizon=20;
figure
plot([1:1:21]', moni.L(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.L(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.L(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('总就业','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('绿色部门产出','FontSize',22)


horizon=20;
figure
plot([1:1:21]', moni.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('棕色部门产出','FontSize',22)


horizon=20;
figure
plot([1:1:21]', moni.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
legend( {'碳税政策','碳税政策+监管政策'},'FontSize',20,'Location','SouthEast')
legend('boxoff','Location','SouthEast') 
title('棕色资产价格','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('绿色资产价格','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.pg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.pg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.pg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('绿色产品价格','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.pb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.pb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.pb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('棕色产品价格','FontSize',22)

horizon=20;
figure
plot([1:1:21]', [0 repelem(0.0399,20)],'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]',[0 repelem(0.0399,20)],'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]',[0 repelem(0.0399,20)],':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
ylim([0 0.045])
set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('碳税税率','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.W(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.W(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.W(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('银行贷款','FontSize',22)

horizon=20;
figure
plot([1:1:21]', moni.C(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;
plot([1:1:21]', moni1.C(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',3, 'Color',[217/255 83/255 25/255] );hold on;
plot([1:1:21]', moni2.C(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',3, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20);
xlim([0 22]) 
%set(gca,'position',[.05  .05  .90  .88])
title('消费','FontSize',22)
 biaoti = [string('1Aggregate output'), string('1Brown Capital'),string('1Green capital'),string('1Aggregate investment'),string('1emissions'),string('1Bank net worth '),...
     string('1Aggregate labor'),string('1Green Production'),string('1Brown production'),string('1price of brown assets'),string('1price of green assets'),string('1price of green products'),string('1price of brown products'),string('1emmision tax'),string('1bank credit'),string('1consumption');]
for i=1:16
    print(i,'-dpng',strcat( char(biaoti(1,i)), '.png'));
end


mean(moni1.I(1:21))
mean(moni.I(1:21))
mean(moni1.I(1:21))-mean(moni.I(1:21))

mean(moni1.Y(1:21))
mean(moni.Y(1:21))
mean(moni1.Y(1:21))-mean(moni.Y(1:21))


mean(moni1.L(1:21))
mean(moni.L(1:21))
mean(moni1.L(1:21))-mean(moni.L(1:21))


moni1.N(1:2)
moni.N(1:2)

moni1.W(1:21)
moni.W(1:21)

moni.Qb(1:2)
moni1.Qb(1:2)
