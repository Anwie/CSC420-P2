function A4Q1f()
load('../data/test/results/detections.mat');
im1 = imread('../data/test/left/004945.jpg');
im2 = imread('../data/test/left/004964.jpg');
im3 = imread('../data/test/left/005002.jpg');
load('../data/test/results/obj3dlocs.mat');
images = {im1,im2,im3};
data = getData('004945', 'test','calib');
[K, R, t] = KRt_from_P(data.P_left);
f = K(1,1);
p_x = K(1,3);
p_y = K(2,3);
for k = 1:size(images,2)    %loop through images
    detections = {detections_car{k} detections_person{k} detections_bike{k}};
    imObj = obj3dloc{k};
    closest_loc = [];
    closest_norm = Inf;
    closest_width = 0;
    closest_class = 0;
    complete = [];
    for m = 1:size(detections,2)    % loop through each class
        for i = 1:size(detections{m},1) %loop through each detection
            x1 = round(max(detections{m}(i,1),0));
            x2 = round(min(detections{m}(i,3),size(images{k},2)));
            if(norm(imObj{m}(i,:),2) < closest_norm)
                closest_loc = imObj{m}(i,:);
                closest_width = (x2 - x1) * imObj{m}(i,3)/f;
                closest_class = imObj{m,2};
                closest_norm = norm(imObj{m}(i,:),2);
            end

            if(imObj{m}(i,1) >= 0)
                side = 'right';
            else
                side = 'left';
            end
            complete = [complete 'a ' imObj{m,2} ' ' rptgen.toString(abs(imObj{m}(i,1)/1000)) 'm to your ' side '; '];
        end
        
    end
    fprintf('Image %d: ',k);
    fprintf('');
    if(closest_loc(1) >= 0)
        side = 'right';
    else
        side = 'left';
    end
    fprintf('The closest traffic is a %s %0.1f meters to your %s.\n', closest_class, abs(closest_loc(1)/1000), side);
    fprintf('It is %0.1f meters away and %0.1f meters wide (from your perspective).\n', closest_norm/1000, closest_width/1000);
    fprintf('There are %d %ss, %d %ss, and %d %ss in total.\n',size(imObj{1,1},1),imObj{1,2},...
        size(imObj{2,1},1),imObj{2,2},size(imObj{3,1},1),imObj{3,2});
    fprintf('They are: %s\n', complete);
end
end

