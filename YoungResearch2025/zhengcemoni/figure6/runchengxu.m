close all;
dynare chengxu1.mod;
dynare chengxu2.mod;
dynare chengxu3.mod;
dynare chengxu4.mod;


moni1 = moni1;
moni2 = moni2;
moni3 = moni3;
moni4 = moni4;

subplot(2,4,3); 
horizon=20;

plot([1:1:21]', moni1.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;

set(gca,'FontSize',20);
box off;
xlim([0 22])
 %set(gca,'position',[.05  .05  .90  .88])
title('总产出','FontSize',26)


subplot(2,4,6); 
horizon=20;

plot([1:1:21]', moni1.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;

set(gca,'FontSize',20); 
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('棕色资本','FontSize',26)

subplot(2,4,5); 
horizon=20;

plot([1:1:21]', moni1.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;


set(gca,'FontSize',20);
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('绿色资本','FontSize',26)



subplot(2,4,2); 
horizon=20;

plot([1:1:21]', moni1.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;

set(gca,'FontSize',20); 
box off;
xlim([0 22])
% set(gca,'position',[.05  .05  .90  .88])
title('总投资','FontSize',26)

subplot(2,4,1); 
horizon=20;

plot([1:1:21]', moni1.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;set(gca,'FontSize',20); 
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('碳排放','FontSize',26)

subplot(2,4,4); 
horizon=20;

plot([1:1:21]', moni1.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;
set(gca,'FontSize',20); 
box off;
xlim([0 22]) 
ylim([-5,1])
%set(gca,'position',[.05  .05  .90  .88])
title('银行净值','FontSize',26)



subplot(2,4,8); 
horizon=20;

plot([1:1:21]', moni1.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.Qb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;
set(gca,'FontSize',20);
box off;
xlim([0 22]) 
ylim([-1 0.1])
%set(gca,'position',[.05  .05  .90  .88])
longLabel = sprintf('减排补贴+碳税\n+宏观审慎政策冲击'); % 生成带换行的字符串
legend( {'减排补贴','碳税','减排补贴+碳税',longLabel},'FontSize',15,'Location','SouthEast')
legend('boxoff','Location','SouthEast') 
title('棕色资产价格','FontSize',26)

subplot(2,4,7); 
horizon=20;

plot([1:1:21]', moni1.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni2.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[255/255 0/255 0/255] );hold on;
plot([1:1:21]', moni3.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[0/255 114/255 189/255] );hold on;
plot([1:1:21]', moni4.Qg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-.k','LineWidth',5, 'Color',[230/255 180/255 40/255] );hold on;

set(gca,'FontSize',20);
box off;
xlim([0 22]) 
ylim([-1 0.1])
%set(gca,'position',[.05  .05  .90  .88])
title('绿色资产价格','FontSize',26)


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
