%% A3_TSedit_Simple

Name_TurbSim_Def='TurbSim_IF\Templates\TurbSim_def';
Name_TurbSim_New='TurbSim_IF\TurbSim';

outputExtension ='hh';

i = 1;
%% Runtime Options
TSeditline{i}='RandSeed1';
TSedit{i}=num2str(20001); i=i+1;
% TSedit{i}=num2str(randi([-2147483648,2147483647],1)); i=i+1;
% TSeditline{i}='RandSeed2';
% TSedit{i}=num2str(randi([-2147483648,2147483647],1)); i=i+1;

%% Turbine/Model Specifications


%% Meteorological Boundary Conditions
TSeditline{i}='IECturbc';
TSedit{i}=['"',Disturbance.Class,'"']; i=i+1;
TSeditline{i}='URef';
TSedit{i}=num2str(Disturbance.U_ref); i=i+1;

%% Non-IEC Meteorological Boundary Conditions

%% Coherent Turbulence Scaling Parameters



%% Run Function

Af_EditTurbSim(TSeditline,TSedit,Name_TurbSim_New,Name_TurbSim_Def,2);


clear TSeditline Fedit DOFLines DOFEdits



