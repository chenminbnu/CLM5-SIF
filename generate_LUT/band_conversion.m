%% load solar spectrum
solar_spec_data = load('solar spectrum.csv');
wavelength = solar_spec_data(:,1);
solar_spec = solar_spec_data(:,2);

solar_spec = interp1(wavelength,solar_spec,[350:1:2500],'linear');
data_narrow =results(:,(760-350+1+7));
%data_hemi =results(:,(760-350+1+7 + 2500-350+1));
%sza = results(:,1);
sza = results(:,7);
data_broad = results(:,((7+700-350+1):(7+2500-350+1)));
data_broad = sum(data_broad.*solar_spec((700-350+1):end),2)/sum(solar_spec((700-350+1):end));
scatplot(data_narrow,data_broad,sza)
figure;
colormap jet
%%
hold on
aa = data_narrow;
bb = data_broad;
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
xlabel('NIR\_760nm')
ylabel('NIR\_broad')


