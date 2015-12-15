function [ ] = prepareEnvironment( )
%% Loading parameters into global workspace
loadParameters;

global parameter;

%% Compiling CPP files
if parameter.useMEXFiles
    compileCMEXFiles;
end

%% Enabling parallel processing
setupNumberOfThreadsToBeUsed;

%% Desabling image size warning
warning ('off', 'images:initSize:adjustingMag');

end

