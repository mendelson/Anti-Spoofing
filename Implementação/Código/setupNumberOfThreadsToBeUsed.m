function [ ] = setupNumberOfThreadsToBeUsed()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global parameter;

if parameter.useParallel
    if parameter.useSpecificPoolSize
        p = gcp('nocreate');

        if ~isempty(p) && p.NumWorkers ~= parameter.poolSize
            delete(gcp);
            parpool('local', parameter.poolSize);
        elseif isempty(p)
            parpool('local', parameter.poolSize);
        end
    end
else
    p = gcp('nocreate');
    
    if ~isempty(p)
        delete(gcp);
    end
end

end

