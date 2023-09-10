%% B_TS_FF_Gen
% Wrapper script to generate hub height turbsim files

clear; tic;

%% Defaults

    %% Wind Parameters
    Disturbance.U_ref       = 12;
    Disturbance.Type        = 'Turb';
    Disturbance.Class       = 'B';
%     Disturbance.TurbModel   = 'WF_07D';

    Disturbance.TurbType    = '1ETM';

   
    %% Turbine Parameters
    
    HubHeight           = 215;
    
    % Scripts & Directories
    Simulation.Name_TSEdit  = 'A3_TSedit_FullField';
%     save_dir                = 'WindFiles/DLC62';
%     save_name               = '<Class>_<U_ref>_<#>';
    
    % Field Parameters
    GridElements        = 18;
    Duration            = 710;
    
    GridHeight          = 420;
    GridWidth           = 420;


%% Scripts & Directories
Simulation.Name_TSEdit  = 'A3_TSedit_FullField';
save_dir                = 'WindFiles/DLC_1_3_25MW';
save_name               = 'ETM_<U_ref>_<#>';


%% Variation
UU = 6:2:24;
N  = 6; % 12;%6;

%% Loop
for U_index = 1:length(UU)
    for n = 1:N
        
        %Assign U_ref
        Disturbance.U_ref = UU(U_index);
        
        
        %Save Name
        save_name = ['ETM_B_',num2str(Disturbance.U_ref),'_',num2str(n)];
        
        %Debug
        disp(['Making FF file ', save_name,', U_ref: ',...
            num2str(Disturbance.U_ref), ', Class: ', Disturbance.Class,...
            ', ',num2str(n),' of ',num2str(N)]);
        
        %Run TurbSim Simulation
                    A2_1_Sim_TurbSim;
        
    end
end

%% Copy Input file into File Directory

toc;