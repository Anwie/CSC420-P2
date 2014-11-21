function Q2()
    for i = 0:94
        if(i < 10)
            imfile = ['um_00000', rptgen.toString(i)];
        else
            imfile = ['um_0000', rptgen.toString(i)];
        end
        getDepth('train', imfile);
    end
        
%     for i = 0:39
%         if(i < 10)
%             imfile = ['umm_00000', rptgen.toString(i)];
%         else
%             imfile = ['umm_0000', rptgen.toString(i)];
%         end
%         getDepth('train', imfile);
%     end
%     
%     for i = 61:95
%         imfile = ['umm_0000', rptgen.toString(i)];
%         getDepth('test', imfile);
%     end
%     
%     for i = 0:50
%         if(i < 10)
%             imfile = ['uu_00000', rptgen.toString(i)];
%         else
%             imfile = ['uu_0000', rptgen.toString(i)];
%         end
%         getDepth('test', imfile);
%     end
end

