%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in an input map and
% builds a disjoint set map from the
% input. Used during connected
% component algorithm.
%--------------------------------------
% Function Definition
%--------------------------------------

function set = FindDisjointSet(inputMap)
    % Loop through the values in the hash map and find the largest ID
    maxLabelID = max(unique(cell2mat(values(inputMap))));
    
    % Make an array of size maxLabelID
    tempLabelSet = zeros(1,maxLabelID);
    
    % Set the value of each item in array to its index initially
    for n=1:maxLabelID
        tempLabelSet(n)=n;
    end
    
    % Using the original input map, merge all the sets together
    for currentKey = cell2mat(keys(inputMap))
        currentKey;
        inputMap(currentKey);
        % Loop through all the values given by this key
        for currentValue = inputMap(currentKey)
            % Merge the sets
            tempLabelSet(tempLabelSet == currentValue) = currentKey;
        end
    end
    
    tempLabelIndex = 1;
    
    % Loops through all of the labels in the label set and relabels them
    for n=1:maxLabelID
        if ismember(n, tempLabelSet)
            tempLabelSet(tempLabelSet == n) = tempLabelIndex;
            tempLabelIndex = tempLabelIndex + 1;
        end
    end
    
    set = tempLabelSet;

end

%--------------------------------------
% End of File
%--------------------------------------