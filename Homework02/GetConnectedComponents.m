%--------------------------------------
% Chris Dalke
% CSC 249 - Homework 02
%--------------------------------------
% Takes in a threshold image and returns
% an image labelled with each of the
% connected components
%--------------------------------------
% Function Definition
%--------------------------------------

function returnImage = GetConnectedComponents(inputImage)
    [height,width,~] = size(inputImage);
    components = inputImage;
    
    for x = 1:width
        for y = 1:height
            if (components(y,x) > 0)
                components(y,x) = -1;
            end
        end
    end

    labelMapNextSet = 1; %Variable storing the next nonexistant set
    labelMap = containers.Map('KeyType','int32','ValueType','any');

    for y = 1:height
        for x = 1:width
            if (components(y,x) == -1)
                %Get all the neighbors' labels
                % NW N NE
                % W  .  E
                % SW S SE
                neighborNW = components(y-1,x-1);
                neighborN = components(y-1,x);
                neighborNE = components(y-1,x+1);
                neighborW = components(y,x-1);
                %neighborE = components(y+1,x);
                %neighborSW = components(y-1,x+1);
                %neighborS = components(y,x+1);
                %neighborSE = components(y+1,x+1);

                if (neighborNW > 0 || neighborN > 0 || neighborNE > 0 || neighborW > 0)
                    %Assign label from its neighbors
                    minLabel = 9999;

                    %While we do this, also add all the items in the set to the
                    %map.
                    tempConnectedLabels = [];

                    if (neighborNW > 0)
                        minLabel = min(minLabel,neighborNW);
                        tempConnectedLabels = [tempConnectedLabels neighborNW];
                    end
                    if (neighborN > 0)
                        minLabel = min(minLabel,neighborN);
                        tempConnectedLabels = [tempConnectedLabels neighborN];
                    end
                    if (neighborNE > 0)
                        minLabel = min(minLabel,neighborNE);
                        tempConnectedLabels = [tempConnectedLabels neighborNE];
                    end
                    if (neighborW > 0)
                        minLabel = min(minLabel,neighborW);
                        tempConnectedLabels = [tempConnectedLabels neighborW];
                    end

                    labelMap(minLabel) = unique([labelMap(minLabel) tempConnectedLabels minLabel]);
                    components(y,x) = minLabel;

                else
                    %Assign a new label and continue
                    components(y,x) = labelMapNextSet;

                    %Add the new label to the label set
                    labelMap(labelMapNextSet) = labelMapNextSet;

                    %Increment the next label set
                    labelMapNextSet = labelMapNextSet + 1;
                end

            end
        end
    end
    imagesc(components);
    saveas(gcf,'Outputs/2_pass1.png');

    connectedComponentSet = FindDisjointSet(labelMap);

    %Relabel the image based on the connected components
    for y = 1:height
        for x = 1:width
            if components(x,y) > 0
                components(x,y) = connectedComponentSet(components(x,y));
            end
        end
    end
    
    imagesc(components);
    saveas(gcf,'Outputs/3_pass2.png');
    
    DrawRegionLabels(components);
    saveas(gcf,'Outputs/4_pass2_labelled.png');
    
    returnImage = components;
end

%--------------------------------------
% End of File
%--------------------------------------