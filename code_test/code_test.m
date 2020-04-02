
clc
clear all;
load('LUTs_all_with_LAD_test.mat');
SZA = results(:,1);
results_tmp = results(SZA<40,:);

% import solar spectrum
solar_spec_data = load('solar spectrum.csv');
wavelength = solar_spec_data(:,1);
solar_spec = solar_spec_data(:,2);
solar_spec = interp1(wavelength,solar_spec,[400:1:2500],'linear');

BNIR = results_tmp(:,((8+700-400+1):(8+2500-400+1)));
BNIR = sum(BNIR.*solar_spec((700-400+1):end),2)/sum(solar_spec((700-400+1):end));
NIRrefl760_0 =results_tmp(:,(760-400+1+8));

BRED = results_tmp(:,((8+400-400+1):(8+700-400+1)));
BRED = sum(BRED.*solar_spec((400-400+1):(700-400+1)),2)/sum(solar_spec((400-400+1):(700-400+1)));
REDrefl650_0 =results_tmp(:,(650-400+1+8));

SZA = cos(results_tmp(:,1)*pi/180);
LAI  = results_tmp(:,6);
LAD  = cos(results_tmp(:,8)*pi/180);

NIRreflHemi = 0.017181 + 1.3844*BNIR - 0.042736*exp(-LAI) - 0.46262*BNIR.*exp(-LAI);
REDreflHemi = -0.024317 + 1.4929*BRED + 0.0095977*exp(-LAI) - 0.26739*BRED.*exp(-LAI);
NIRrefl760 = -0.12733 + 0.28725*NIRreflHemi + 0.18878*SZA + 0.11983*LAD + 0.29361*NIRreflHemi.*SZA + 0.69392*NIRreflHemi.*LAD - 0.18776*SZA.*LAD - 0.14712*NIRreflHemi.*SZA.*LAD;
REDrefl650 = -0.0039848 + 0.13994*REDreflHemi + 0.021598*SZA + 0.0048785*LAD + 0.57839*REDreflHemi.*SZA + 0.85545*REDreflHemi.*LAD - 0.023785*SZA.*LAD - 0.52124*REDreflHemi.*SZA.*LAD;
% print *, laitmp, cosz,  cos_avgleafangle, albd(p,2), forc_solad(g,2), albi(p,2), forc_solai(g,2), BNIR, NIRreflHemi, NIRrefl760
NDVI = (NIRrefl760-REDrefl650) ./ (NIRrefl760+REDrefl650);
NIRv = NDVI .* NIRrefl760;
NDVI_broad = (BNIR-BRED) ./ (BNIR+BRED);
NIRv_broad = NDVI_broad.*BNIR;
% NDVI NIRv
figure;
subplot(121)
hold on
scatplot(NDVI, NDVI_broad)
plot([0 1], [0 1])
axis([0 1 0 1])
xlabel('NDVI\_narrow')
ylabel('NDVI\_broad')
subplot(122)
hold on
scatplot(NIRv, NIRv_broad)
plot([0 1], [0 1])
axis([0 1 0 1])
xlabel('NIRv\_760')
ylabel('NIRv\_broad')

% Reflectance
figure;
subplot(221)
hold on
scatplot(BNIR, NIRrefl760)
plot([0 1], [0 1])
axis([0 1 0 1])
xlabel('NIR\_broad')
ylabel('NIR\_760')
subplot(222)
hold on
scatplot(NIRrefl760_0, NIRrefl760)
plot([0 1], [0 1])
axis([0 1 0 1])
xlabel('NIR\_760\_reference')
ylabel('NIR\_760')

subplot(223)
hold on
scatplot(BRED, REDrefl650)
plot([0 1], [0 1])
axis([0 1 0 1])
xlabel('Red\_broad')
ylabel('Red\_650')
subplot(224)
hold on
scatplot(REDrefl650_0, REDrefl650)
plot([0 1], [0 1])
axis([0 1 0 1])
xlabel('Red\_650\_reference')
ylabel('Red\_650')

