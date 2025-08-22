close all;
dynare cxb31.mod;
dynare cxb33.mod;
dynare cxb35.mod;


moni1 = moni1;
moni3 = moni3;
moni5 = moni5;

figure

subplot(2,4,3); 
horizon=20;
plot([1:1:21]', moni3.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.Y(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20); 
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('�ܲ���','FontSize',26)



subplot(2,4,8); 
horizon=20;
plot([1:1:21]', moni3.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.Kb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20); 
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
legend( {'�޽���Ħ��','�н���Ħ��','�н���Ħ��+�����������'},'FontSize',16,'Location','SouthWest')
legend('boxoff','Location','SouthEast') 
title('��ɫ�ʱ�','FontSize',26)

subplot(2,4,7); 
horizon=20;
plot([1:1:21]', moni3.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.Kg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20);
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ�ʱ�','FontSize',26)



subplot(2,4,2); 
horizon=20;
plot([1:1:21]', moni3.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.I(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��Ͷ��','FontSize',26)

subplot(2,4,1);
horizon=20;
plot([1:1:21]', moni3.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.e_b(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20);
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('̼�ŷ�','FontSize',26)


subplot(2,4,4); 
horizon=20;
plot([1:1:21]', moni1.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0 0] );hold on;
plot([1:1:21]', moni5.N(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;

set(gca,'FontSize',20); 
box off;
xlim([0 22]) 
ylim([0,30])
%set(gca,'position',[.05  .05  .90  .88])
title('���о�ֵ','FontSize',26)



subplot(2,4,5);
horizon=20;
plot([1:1:21]', moni3.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.Yg(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20);
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ���Ų���','FontSize',26)

subplot(2,4,6); 
horizon=20;

plot([1:1:21]', moni3.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'-k','LineWidth',5, 'Color',[255/255 0 0] );hold on;
plot([1:1:21]', moni1.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),':k','LineWidth',5, 'Color',[0 0/255 0/255] );hold on;
plot([1:1:21]', moni5.Yb(1+moni.M_.maximum_lag-1:horizon+moni.M_.maximum_lag),'--k','LineWidth',5, 'Color',[0 114/255 189/255] );hold on;
set(gca,'FontSize',20);
box off;
xlim([0 22])
%set(gca,'position',[.05  .05  .90  .88])
title('��ɫ���Ų���','FontSize',26)






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
