bandnum = 650;% 757 771 650


results = real(results);
data_nadir =results(:,(bandnum - 400+1+11));
data_hemi =results(:,(bandnum -400+1+11 + 2500-400+1));
sza = results(:,1);
Cab = results(:,2);
Cw = results(:,3);
Cm  = results(:,4);
N  = results(:,5);
LAI  = results(:,6);
psoil  = results(:,7);
LAD  = results(:,8);
skyl =  results(:,11);
% tbl = table(d results(:,8);ata_nadir,data_hemi,cos(sza*pi/180),Cab,Cw,Cm,N,LAI,psoil,cos(LAD*pi/180),sin(sza*pi/180),sin(LAD*pi/180),...
%     'VariableNames',{'data_nadir','data_hemi','sza','Cab','Cw','Cm','N','LAI','psoil','LAD','sin_sza','sin_LAD'});
% lm = fitlm(tbl,'data_nadir~data_hemi+sza+LAD+sin_sza+sin_LAD');

% %%
% figure
% subplot(1,2,1)
% hold on
% aa = data_nadir;
% bb = predict(lm);
% scatplot(aa, bb)
% plot([0 1],[0 1],'k-','LineWidth',1)
% 
% relation =  polyfit(aa,bb,1);
% 
% box on
% set(gca,'LineWidth',2,'FontSize',12)
% plot([0. 1],[ polyval(relation,0) polyval(relation,1)],'r-','LineWidth',1)
% 
% 
% coef1  = corrcoef(aa,bb);
% R_value = coef1(1,2);
% R2 = R_value^2;
% RMSE = sqrt(mean((aa-bb).^2));
% text(0.05,0.92,['y=',num2str(relation(1,1),'%5.3f'),'x+' num2str(relation(1,2),'%5.3f') ],'Color','r','FontName','Time New Roman','FontSize',12);
% text(0.05,0.85,['R^2=',num2str(R2,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',12);
% text(0.05,0.72,['RMSE=',num2str(RMSE,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',12);
% 
% axis([0 1 0 1])
% xlabel('Observed')
% ylabel('Predicted')
% title('Without interaction')
%% regress
tbl = table(data_nadir,data_hemi,cos(sza*pi/180),Cab,Cw,Cm,N,LAI,psoil,cos(LAD*pi/180),sin(sza*pi/180),sin(LAD*pi/180),skyl,...
    'VariableNames',{'data_nadir','data_hemi','sza','Cab','Cw','Cm','N','LAI','psoil','LAD','sin_sza','sin_LAD','skyl'});
lm = fitlm(tbl,'data_nadir~data_hemi*sza*LAD');

lm

%% plot
figure
hold on
aa = data_nadir;
bb = predict(lm);
scatplot(aa, bb)
plot([0 1],[0 1],'k-','LineWidth',1)

relation =  polyfit(aa,bb,1);

box on
set(gca,'LineWidth',2,'FontSize',12)
plot([0. 1],[ polyval(relation,0) polyval(relation,1)],'r-','LineWidth',1)


coef1  = corrcoef(aa,bb);
R_value = coef1(1,2);
R2 = R_value^2;
RMSE = sqrt(mean((aa-bb).^2));
text(0.05,0.92,['y=',num2str(relation(1,1),'%5.3f'),'x+' num2str(relation(1,2),'%5.3f') ],'Color','r','FontName','Time New Roman','FontSize',15);
text(0.05,0.82,['R^2=',num2str(R2,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',15);
text(0.05,0.72,['RMSE=',num2str(RMSE,'%5.3f')],'Color','r','FontName','Time New Roman','FontSize',15);

axis([0 1 0 1])
xlabel('Observed')
ylabel('Predicted')
title('With interaction')
set(gca, 'fontsize', 15)