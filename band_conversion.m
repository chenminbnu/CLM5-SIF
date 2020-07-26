%% load solar spectrum
solar_spec_data = load('solar spectrum.csv');
wavelength = solar_spec_data(:,1);
solar_spec = solar_spec_data(:,2);

solar_spec = interp1(wavelength,solar_spec,[400:1:2500],'linear');

%% import spectral data
results = real(results);

data_hemi =results(:,((1+11 + 2500-400+1):(2500-400+1 + 11 + 2500-400+1)));
%data_hemi =results(:,((1+8):(2500-400+1 + 8)));

sza = results(:,1);
Cab = results(:,2);
Cw = results(:,3);
Cm  = results(:,4);
N  = results(:,5);
LAI  = results(:,6);
psoil  = results(:,7);
LAD  = results(:,8);
skyl = results(:,11);

bandnum = 757;% 771 757 680
data_narrow =data_hemi(:,(bandnum -400+1));

if(bandnum>700)
data_broad = data_hemi(:,((700-400+1):(2500-400+1)));
data_broad = sum(data_broad.*solar_spec((700-400+1):end),2)/sum(solar_spec((700-400+1):end));
else
data_broad = data_hemi(:,((400-400+1):(700-400+1)));
data_broad = sum(data_broad.*solar_spec((400-400+1):(700-400 + 1)),2)/sum(solar_spec((400-400+1):(700-400 + 1)));

end

tbl = table(data_narrow,data_broad,cos(sza*pi/180),Cab,Cw,Cm,N,exp(-LAI),psoil,cos(LAD*pi/180),sin(sza*pi/180),sin(LAD*pi/180),skyl,...
    'VariableNames',{'data_narrow','data_broad','sza','Cab','Cw','Cm','N','LAI','psoil','LAD','sin_sza','sin_LAD','skyl'});

%% regress
lm = fitlm(tbl,'data_narrow~data_broad*LAI');

lm
%% plot
figure
hold on
aa = data_narrow;
bb = predict(lm);

filters = aa>0 & bb>0 & aa<1 & bb<1;
aa = aa(filters);
bb = bb(filters);

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

set(gca, 'fontsize', 15)

axis([0 1 0 1])
xlabel('Observed')
ylabel('Predicted')

