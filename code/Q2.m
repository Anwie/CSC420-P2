% Calls get3D on each image, and places the
% results in ../data/<train or test>/results/get3D/
function Q2()
    globals;
    outdir = fullfile(DATA_DIR, 'train', 'results', 'get3D');
    if ~exist(outdir, 'dir')
        mkdir(outdir);
    end;
    for i = 0:94
        imfile = sprintf('um_%06d', i);
        get3D('train', imfile);
    end
        
    for i = 0:39
        imfile = sprintf('umm_%06d', i);
        get3D('train', imfile);
    end
    
    outdir = fullfile(DATA_DIR, 'test', 'results', 'get3D');
    if ~exist(outdir, 'dir')
        mkdir(outdir);
    end;
    for i = 61:95
        imfile = sprintf('umm_%06d', i);
        get3D('test', imfile);
    end
    
    for i = 0:50
        imfile = sprintf('uu_%06d', i);
        get3D('test', imfile);
    end
end

