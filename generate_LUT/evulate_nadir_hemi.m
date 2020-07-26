data_nadir =results(:,(760-350+1+7));
data_hemi =results(:,(760-350+1+7 + 2500-350+1));
sza = results(:,1);
R = corrcoef(data_nadir./data_hemi, sza)
figure;
scatter( sza, data_nadir./data_hemi)
xlabel('SZA')
ylabel('Nadir Reflectance/Albedo')
figure;
colormap jet
%%
subplot(2,2,1)
hold on
filter = sza<20;
aa = data_nadir(filter);
bb = data_hemi(filter);
scatplot(aa, bb)
plot([0 1],[0 1],'k-','LineWidth',1)

relation =  polyfit(aa,bb,1);

box on
set(gca,'LineWidth',2,'FontSize',12)
plot([0. 1],[ polyval(relation,0) polyval(relation,1)],'r-','LineWidth',1)


coef1  = corrcoef(aa,bb);
R_value = coef1(1,2);
R2 = R_value^2;
text(0.05,0.92,['y=',num2str(relation(1,1),'%5.3f'),'x+' num2str(relation(1,2),'%5.3f') ],'Color','r','FontName','Time New Roman','FontSize',12);
text(0.05,0.75,['R^2=',num2str(R2,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',12);

axis([0 1 0 1])
title('SZA<20бу')
xlabel('Nadir Reflectance')
ylabel('Albedo')

%%
subplot(2,2,2)
hold on
filter = sza>=20 & sza<40;
aa = data_nadir(filter);
bb = data_hemi(filter);
scatplot(aa, bb)
plot([0 1],[0 1],'k-','LineWidth',1)

relation =  polyfit(aa,bb,1);

box on
set(gca,'LineWidth',2,'FontSize',12)
plot([0. 1],[ polyval(relation,0) polyval(relation,1)],'r-','LineWidth',1)


coef1  = corrcoef(aa,bb);
R_value = coef1(1,2);
R2 = R_value^2;
text(0.05,0.92,['y=',num2str(relation(1,1),'%5.3f'),'x+' num2str(relation(1,2),'%5.3f') ],'Color','r','FontName','Time New Roman','FontSize',12);
text(0.05,0.75,['R^2=',num2str(R2,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',12);

axis([0 1 0 1])
title('20бу<SZA<40бу')
xlabel('Nadir Reflectance')
ylabel('Albedo')

%%
subplot(2,2,3)
hold on
filter = sza>=40 & sza<60;
aa = data_nadir(filter);
bb = data_hemi(filter);
scatplot(aa, bb)
plot([0 1],[0 1],'k-','LineWidth',1)

relation =  polyfit(aa,bb,1);

box on
set(gca,'LineWidth',2,'FontSize',12)
plot([0. 1],[ polyval(relation,0) polyval(relation,1)],'r-','LineWidth',1)


coef1  = corrcoef(aa,bb);
R_value = coef1(1,2);
R2 = R_value^2;
text(0.05,0.92,['y=',num2str(relation(1,1),'%5.3f'),'x+' num2str(relation(1,2),'%5.3f') ],'Color','r','FontName','Time New Roman','FontSize',12);
text(0.05,0.75,['R^2=',num2str(R2,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',12);

axis([0 1 0 1])
title('40бу<SZA<60бу')
xlabel('Nadir Reflectance')
ylabel('Albedo')

%%
subplot(2,2,4)
hold on
filter = sza>=60;
aa = data_nadir(filter);
bb = data_hemi(filter);
scatplot(aa, bb)
plot([0 1],[0 1],'k-','LineWidth',1)

relation =  polyfit(aa,bb,1);

box on
set(gca,'LineWidth',2,'FontSize',12)
plot([0. 1],[ polyval(relation,0) polyval(relation,1)],'r-','LineWidth',1)


coef1  = corrcoef(aa,bb);
R_value = coef1(1,2);
R2 = R_value^2;
text(0.05,0.92,['y=',num2str(relation(1,1),'%5.3f'),'x+' num2str(relation(1,2),'%5.3f') ],'Color','r','FontName','Time New Roman','FontSize',12);
text(0.05,0.75,['R^2=',num2str(R2,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',12);

axis([0 1 0 1])
title('SZA>60бу')
xlabel('Nadir Reflectance')
ylabel('Albedo')
