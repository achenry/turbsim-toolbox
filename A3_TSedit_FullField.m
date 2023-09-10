%% A3_TSedit_FullField
function [outputExtension] = A3_TSedit_FullField(Disturbance, Meteor, Field, Name_TurbSim_Def, Name_TurbSim_New, Dir_TurbSim_Temp)
outputExtension ='bts';
i = 1;
%% Runtime Options
TSeditline{i}='RandSeed1';
TSedit{i}=num2str(randi([-2147483648,2147483647],1)); i=i+1;
TSeditline{i}='RandSeed2';
TSedit{i}=num2str(randi([-2147483648,2147483647],1)); i=i+1;

%% Turbine/Model Specifications

%Time
TSeditline{i}='AnalysisTime';
TSedit{i}=num2str(Field.Duration); i=i+1;
TSeditline{i}='UsableTime';
TSedit{i}=num2str(Field.Duration); i=i+1;

%Grid
TSeditline{i}='NumGrid_Z';
TSedit{i}=num2str(Field.GridElements); i=i+1;
TSeditline{i}='NumGrid_Y';
TSedit{i}=num2str(Field.GridElements); i=i+1;



TSeditline{i}='HubHt';
TSedit{i}=num2str(Meteor.HubHeight); i=i+1;
TSeditline{i}='GridHeight';
TSedit{i}=num2str(Field.GridHeight); i=i+1;
TSeditline{i}='GridWidth';
TSedit{i}=num2str(Field.GridWidth); i=i+1;




%% Meteorological Boundary Conditions
TSeditline{i}='IECturbc';
TSedit{i}=['"',Disturbance.Class,'"']; i=i+1;
TSeditline{i}='URef';
TSedit{i}=num2str(Disturbance.U_ref); i=i+1;

TSeditline{i}='RefHt';
TSedit{i}=num2str(Meteor.RefHeight); i=i+1;

TSeditline{i}='PLExp';
TSedit{i}=num2str(Meteor.PLExpo); i=i+1;

% if strcmp(Disturbance.TurbType,'ETM')
    
    %"NTM"               IEC_WindType    - IEC turbulence type ("NTM"=normal, "xETM"=extreme turbulence, "xEWM1"=extreme 1-year wind, "xEWM50"=extreme 50-year wind, where x=wind turbine class 1, 2, or 3)
TSeditline{i}='IEC_WindType';
TSedit{i}= Disturbance.TurbType; i=i+1;
% end

% TSeditline{i}='TurbModel';
% TSedit{i}=num2str(Disturbance.TurbModel); i=i+1;

%% Non-IEC Meteorological Boundary Conditions

%% Coherent Turbulence Scaling Parameters



%% Run Function

Af_EditTurbSim(TSeditline,TSedit,Name_TurbSim_New,Name_TurbSim_Def, Dir_TurbSim_Temp, 2);


%clear TSeditline Fedit DOFLines DOFEdits


end