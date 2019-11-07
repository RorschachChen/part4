function Cam = Get_cameras_parameter(filepath)
fid = fopen(filepath);
frame_num = fscanf(fid, '%d', 1);
Cam_K = cell(frame_num, 1);
Cam_R = cell(frame_num, 1);
Cam_T = cell(frame_num, 1);
Cam_C = cell(frame_num, 1);
for i_frame = 1:141    
    Cam_K{i_frame} = fscanf(fid, '%f', [3,3])';
    Cam_R{i_frame} = fscanf(fid, '%f', [3,3])';
    Cam_T{i_frame} = fscanf(fid, '%f', [1,3])';
    Cam_C{i_frame} = -Cam_R{i_frame}' * Cam_T{i_frame};
end
fclose(fid);
Cam.K = Cam_K;
Cam.R = Cam_R;
Cam.T = Cam_T;
Cam.C = Cam_C;
Cam = struct2table(Cam);
end
