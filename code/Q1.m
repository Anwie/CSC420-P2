% Calls getDisparity on each image, and places the
% results in ../data/<train or test>/results/getDisparity/
function Q1()
    for i = 0:94
        imfile = sprintf('um_%06d', i);
        getDisparity('train', imfile);
    end
    
    for i = 0:39
        imfile = sprintf('umm_%06d', i);
        getDisparity('train', imfile);
    end
    
    for i = 61:95
        imfile = sprintf('umm_%06d', i);
        getDisparity('test', imfile);
    end
    
    for i = 0:50
        imfile = sprintf('uu_%06d', i);
        getDisparity('test', imfile);
    end
end