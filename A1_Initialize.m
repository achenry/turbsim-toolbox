%% A1_Initialize
% J.Aho 9/22/11

% This code will set up your present working directory, add the paths for
% functions, templates and data and you can declare the directory in which
% the turbsim wind files are stored

%clc
format compact

% Set A_CD as the present working directory
global A_CD 
A_CD = pwd;

%Add patsh of functions, templates and data to be loaded
% addpath(fullfile(A_CD,'A_Functions'));
% addpath(fullfile(A_CD,'TurbSim_IF'));


warning on all
warning off Simulink:blocks:TDelayTimeTooSmall

