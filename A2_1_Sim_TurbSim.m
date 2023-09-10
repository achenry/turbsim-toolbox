%% A2_1_Sim_TurbSim
% Main script to setup TurbSim Parameters and Generate Files
function [] = A2_1_Sim_TurbSim(Disturbance, Simulation, Meteor, Field, turbsim_exe, Name_TurbSim_Def, Name_TurbSim_New, Dir_TurbSim_Temp)

    %% Edit Input Files TODO para workspace argument not specified as 'caller'
    [outputExtension] = feval(Simulation.Name_TSEdit, Disturbance, Meteor, Field, Name_TurbSim_Def, Name_TurbSim_New, Dir_TurbSim_Temp);
    
    %% Run TurbSim
    
    disp('Running turbsim');
    [~, save_name, ~] = fileparts(Name_TurbSim_New);
    [~,r] = system([turbsim_exe, ' ', Name_TurbSim_New, '.inp'])
   
    
%     %% Move Files
%     [save_dir, ~, ~] = fileparts(Name_TurbSim_New);
%     if ~isdir(save_dir)
%         mkdir(save_dir)
%     end
%     
%     movefile(['./TurbSim_IF/', save_name, '.',outputExtension],fullfile(save_dir,[save_name,'.',outputExtension]));
%     movefile(['./TurbSim_IF/', save_name, '.sum'],fullfile(save_dir,[save_name,'.sum']));
    
    
    %% Post Processing
    %A4_1_View_HH()
    %A4_1_View_FF;

end
