

%% generate 100, 000 uniform distributions
Par_info.min=[ 0, 1,    0.001,  0.001,  1,  0.1, 0,0, 0, 0, 0];
Par_info.max=[  85, 80,     0.1,  0.05,  2.5, 8, 1,90, 90, 180, 1];
parameters = lhsu(Par_info.min,Par_info.max,100000);


%% simulation
results = zeros(100000,4213);
for i = 1:100000
    tts =  parameters(i,1);
    Cab = parameters(i,2);
    Cw = parameters(i,3);
    Cm  = parameters(i,4);
    N  = parameters(i,5);
    LAI  = parameters(i,6);
    psoil  = parameters(i,7);
    LAD = parameters(i,8);
    VZA  = parameters(i,9);
    RAA = parameters(i,10);
    skyl = parameters(i,11);

    reflectance = PROSAIL_5B_main(tts, Cab, Cw, Cm, N, LAI, psoil,LAD,VZA, RAA, skyl);
    results(i,:) = [tts Cab Cw Cm N LAI psoil LAD VZA RAA  skyl reflectance];
end

%% save results
save(['LUTs_all_direction_all_skyl.mat'],'results','-v7.3');