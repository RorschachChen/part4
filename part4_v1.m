clc
clear
tic

addpath('./GCMex');
addpath('./part4');
addpath('./Road');

cam_file = './Road/cameras.txt';
cam = Get_cameras_parameter(cam_file);
frame_num = 141;
near_frame = 10;

fileList = dir(fullfile('./Road/src/',['*.','jpg']));
filePath = cell(frame_num, 1);
for i=1:length(fileList)
    filePath{i,1}=fullfile(fileList(i).folder, fileList(i).name);
end

ims = cellfun(@(path)(double(imread(path))),filePath, 'UniformOutput', 0);

result_root = './part4/Result/init/';

for i=1:length(ims)
    im_path = fullfile(result_root, sprintf('test%04d.png', i-1));
    if exist(im_path,'file') 
        continue;  
    end
    idx_tp = i-near_frame:i+near_frame;
    idx_tp(near_frame+1) = [];
    idx_tp(idx_tp<1|idx_tp>length(ims)) = [];
    image_flow  = [ ims(i);     ims(idx_tp)  ];
    cam_flow = [cam(i,:);  cam(idx_tp,:)];
    LABELS = GraphComput(image_flow, cam_flow);
    pic = uint8(LABELS);
    imwrite(pic, im_path);
end




Nframes = 1:10;