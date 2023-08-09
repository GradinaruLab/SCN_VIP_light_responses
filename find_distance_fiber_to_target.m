function [distance_fiber_scn_center] = find_distance_fiber_to_target(mouse, exp)
%% this function is used to find distance of fiber from target, based on coordinates found using 
%'cell_quantification_zstack_assitance' for fiber  coordinates
% and 'find_fluor_quantification_zstack_10umStep_042820' for target
% coordinates


if nargin == 0
    %%% set parameters
    %mouse='VIPGFP14RL'
    %mouse='VIPGC106LL'
    %mouse='VIPGC113L'
    %  mouse='VIPGC115L'
    %mouse='VIPGC162'
    %mouse='VIPGC129L';
    % mouse='VIPGC128R';
    %mouse='VIPGC62L';
    
    mouse='VIPGC371R';
    
    %exp='room_light';
    exp='red_4e14';
end


mypath='D:\DATA_Glab';
%mypath='C:\Users\anatk\Documents\Data_Glab_home_work';
%%% tiff files quality is much better here
%file_name='LGS_SCN_VIP2';ni=1;;
switch exp
    case 'room_light'
        file_name='LGS_SCN_VIP';
    case 'red_4e14'
        file_name='LGS_SCN_VIP_red_light';
end
ni=1;
%[NUMpar,TXTpar,RAWpar]=xlsread([mypath '\' file_name '.xlsx']);
T=readtable([mypath '\' file_name '.xlsx']);
raw_ind=find(strcmp(T.ID,mouse));
raw_ind=raw_ind(1);

this_path=T.path{raw_ind};
%this_path='Z:\Anat\SCN_rep\Rep_SCN_histology\';
folder=[this_path T.LGSFile_name{raw_ind}];
%folder=[TXTpar{raw_ind,7+ni} TXTpar{raw_ind,8+ni}];
step=T.VIP(raw_ind); % image step. can be found in Zen image info
num_channel=T.num_channels(raw_ind);
fiber_image_ind=T.fiber_image_ind(raw_ind)-1; % index of image scn is best expressed
min_X=T.min_X_whereSCNStarts_ForImage_(raw_ind);
GFP_ch=T.GFP_ch(raw_ind);
pixel_to_um=T.pixel_to_um(raw_ind);

% num_channel=RAWpar{raw_ind,10+ni};
% fiber_image_ind=RAWpar{raw_ind,14+ni}-1; % index of image scn is best expressed
%scn_range=RAWpar{raw_ind,12};
% min_X=RAWpar{raw_ind,16+ni};
% GFP_ch=RAWpar{raw_ind,15+ni};
% side=RAWpar{raw_ind,5+ni};

side=T.reocrdedSide{raw_ind};
switch side; case 'R'; side_ind=2; case 'L'; side_ind=1; end
switch mouse; case 'VIPGC366L'; side_ind=2; end
switch mouse; case 'VIPGC313RL'; side_ind=1; end

% load fiber coordinates
cd(folder)
clear x y
load('fiber_4_coordinates.mat')
Xfiber=abs(x(4)-x(2));
Yfiber=abs(y(3)-y(1));
% load target coordinates

clear x y
load('scn_coordinates.mat') % first index is bottom, which is L
Xtarget=x(side_ind);
Ytarget=y(side_ind);

load('SCN_to_fiber_distance')

%pixel_to_um=0.42;
%sqrt(X^2+Y^2+Z^2)
distance_fiber_scn_center=sqrt((pixel_to_um*(Xfiber-Xtarget))^2+(pixel_to_um*(Yfiber-Ytarget))^2+MAX_GFP_distance_fiber^2);
