% data = getData([], [], 'detector-car');
% model = data.model;
 col = 'r';
testimages = ['004945','004964','005002','005043','005102','005204','005395', ...
    '005417','005507','005572','006003','006242','006374','006375','006655', ...
    '006719','006815','006848','007264','007414'];

detections_person = cell(20,1);% = [ds004945];%,ds004964,'005002','005043','005102','005204','005395', ...
    %'005417','005507','005572','006003','006242','006374','006375','006655', ...
    %'006719','006815','006848','007264','007414'];
load('VOC2010/person_final');
model.vis = @()visualizemodel(model, ...
    1:2:length(model.rules{model.start}));
model.thresh = -0.7;
for i = 0:19
imdata = getData(testimages(i*6+1:(i+1)*6), 'test', 'left');
im = imdata.im;
f = 1.5;
imr = imresize(im,f); % if we resize, it works better for small objects

% detect objects
fprintf('running the detector, may take a few seconds...\n');
tic;
[ds, bs] = imgdetect(imr, model, model.thresh); % you may need to reduce the threshold if you want more detections
e = toc;
fprintf('finished! (took: %0.4f seconds)\n', e);
nms_thresh = 0.5;
top = nms(ds, nms_thresh);
if model.type == model_types.Grammar
  bs = [ds(:,1:4) bs];
end
if ~isempty(ds)
    % resize back
    ds(:, 1:end-2) = ds(:, 1:end-2)/f;
    bs(:, 1:end-2) = bs(:, 1:end-2)/f;
showboxesMy(im, reduceboxes(model, bs(top,:)), col);
end;
%fprintf('detections:\n');
detections_person{i+1} = ds(top, :);
end