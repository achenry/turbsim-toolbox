%% B_TS_HH_Gen
% Wrapper script to generate hub height turbsim files

clear; tic;

%% Defaults
% Wind Parameters
Disturbance.U_ref   = 10;
Disturbance.Type    = 'Turb';
Disturbance.Class   = 'A';

% Scripts & Directories
Simulation.Name_TSEdit  = 'A3_TSedit_Simple';
save_dir                = 'WindFiles';
save_name               = '<Class>_<U_ref>_<#>';

%% Variation
N  = 2; %6;
%% Loop
for U_index = 1:length(UU)
    for C_index = 1:length(CC)
        for n = 1:N
            
            %Assign U_ref
            Disturbance.U_ref = UU(U_index);
            
            %Assign Class
            Disturbance.Class = CC{C_index};
            
            %Save Name
            save_name = [Disturbance.Class,'_',num2str(Disturbance.U_ref),'_',num2str(n),'.hh'];            
            
            %Debug
            disp(['Making HH file ', save_name,', U_ref: ',...
                num2str(Disturbance.U_ref), ', Class: ', Disturbance.Class,...
                ', ',num2str(n),' of ',num2str(N)]);
            
            %Run TurbSim Simulation
            A2_1_Sim_TurbSim;
            
        end
    end
end


toc;