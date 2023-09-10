%% B_TS_FF_Gen
% Wrapper script to generate hub height turbsim files

tic;

A1_Initialize;

if ismac
    home_dir = '/Users/aoifework/Documents';
    project_dir = fullfile(home_dir, 'Research/ipc_tuning/');

    % turbsim_exe = fullfile(home_dir, 'usflowt_src/openfast/install/bin/turbsim');
    turbsim_exe = fullfile(home_dir, 'dev/WEIS/local/bin/turbsim');
    % turbsim_exe = fullfile(home_dir, 'dev/WEIS/OpenFAST/install/bin/turbsim');
    save_dir = fullfile(project_dir, 'WindFiles/');

    % addpath(fullfile(home_dir, 'toolboxes/matlab-toolbox/A_Functions'));
    addpath(fullfile(home_dir, 'toolboxes/matlab-toolbox/Utilities'));
    addpath(fullfile(home_dir, 'toolboxes/turbsim-toolbox/A_Functions'));

    Dir_TurbSim_Temp = fullfile(home_dir, 'toolboxes', 'turbsim-toolbox', 'Templates');
    Name_TurbSim_Def=fullfile(Dir_TurbSim_Temp, 'TurbSim_FF_def');
elseif isunix
    
    home_projects_dir = '/projects/aohe7145';
    home_storage_dir = '/scratch/summit/aohe7145';
    project_dir = fullfile(home_projects_dir, 'projects/ipc_tuning');

    turbsim_exe = fullfile(home_projects_dir, 'toolboxes/dev/WEIS/OpenFAST/install/bin/turbsim');
    save_dir = fullfile(home_storage_dir, 'WindFiles/rated_turbulent');

    % addpath(fullfile(home_projects_dir, 'toolboxes/dev/matlab-toolbox/A_Functions'));
    addpath(fullfile(home_projects_dir, 'toolboxes/matlab-toolbox/Utilities'));
    % addpath(fullfile(home_projects_dir, 'toolboxes/turbsim-toolbox/A_Functions/'));
    
    Dir_TurbSim_Temp = fullfile(home_dir, 'toolboxes', 'turbsim-toolbox', 'Templates');
    Name_TurbSim_Def=fullfile(Dir_TurbSim_Temp, 'TurbSim_FF_def');
end

if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

%% Variation
UU = 12:2:24;
CC = {'18'}; % IECturbc
N  = 1:5;

%% Setup Cases
case_basis.UU = UU;
case_basis.CC = CC; % IECturbc
case_basis.N = N;
case_basis.PLExpo = [0.2]; % wind shear exponent
case_basis.TurbType = {'NTM'}; % 3ETM Class III extreme turbulence model, IEC_WindType

namebase = [case_basis.TurbType{1}, '_', CC{1}, '_', num2str(UU(1))];
fast_fmt = false;
[case_list, case_name_list, n_cases]  = generateCases(case_basis, namebase, fast_fmt);

% A3_TSedit_FullField
Simulation = repmat( struct('Name_TSEdit', 'A3_TSedit_FullField' ), n_cases, 1 );
Disturbance = repmat( struct('TurbType', case_basis.TurbType{1}, 'Class', CC{1}, 'U_ref', 0), n_cases, 1 );
Meteor = repmat( struct('HubHeight', 193.287, 'RefHeight', 193.287, 'PLExpo', 0.2), n_cases, 1 );
Field = repmat( struct('GridElements', 21, 'Duration', 710, 'GridHeight', 380, 'GridWidth', 380), n_cases, 1 );

%% Loop
parfor case_idx = 1:n_cases
    
    Disturbance(case_idx).U_ref = case_list(case_idx).UU;
    Disturbance(case_idx).Class = case_list(case_idx).CC;
    Disturbance(case_idx).Seed = case_list(case_idx).N;
    Disturbance(case_idx).TurbType = case_list(case_idx).TurbType;

    Meteor(case_idx).PLExp = case_list(case_idx).PLExpo;
    
    %Save Name
    if strcmp(Disturbance(case_idx).TurbType,'ETM')
        save_name = ['ETM_',Disturbance(case_idx).Class,'_', ...
            replace(num2str(Disturbance(case_idx).U_ref), '.', '-'),'_',...
            num2str(Disturbance(case_idx).Seed)];
    else
        save_name = [Disturbance(case_idx).Class,'_', ...
            replace(num2str(Disturbance(case_idx).U_ref), '.', '-'),'_',...
            num2str(Disturbance(case_idx).Seed)];
    end
    
    %Debug
    disp(['Making FF file ', save_name,', U_ref: ',...
        num2str(Disturbance(case_idx).U_ref), ...
        ', Class: ', Disturbance(case_idx).Class,...
        ', ',num2str(Disturbance(case_idx).Seed),' of ', num2str(N)]);


    Name_TurbSim_New = fullfile(save_dir, save_name);

    %Run TurbSim Simulation
    A2_1_Sim_TurbSim(Disturbance(case_idx), Simulation(case_idx), ...
        Meteor(case_idx), Field(case_idx), turbsim_exe, Name_TurbSim_Def, ...
        Name_TurbSim_New, Dir_TurbSim_Temp);
end

%% Copy Input file into File Directory

toc;