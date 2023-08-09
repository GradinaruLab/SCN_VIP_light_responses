function MAX_GFP_distance_fiber=find_fluor_exp_above_fiber_v2(mouse, exp)
%% to run this script save Zen images as tiff
%% this function is used to fund fluorscence above fiber

if nargin == 0
    %%% set parameters
    %mouse='VIPGFP14RL'
    %mouse='VIPGC106LL'
    %mouse='VIPGC113L'
    %  mouse='VIPGC115L'
    %mouse='VIPGC162'
    mouse='VIPGC129L';
   %  mouse='VIPGC122R';
    % mouse='VIPGC128R';
    %mouse='VIPGC62L';
    
    mouse='VIPGC371R';
    
    exp='red_4e14';
end


RI=1; % RIseeBD is 1.48, but is neglactible
str_to_find='-2048y0';
mypath='D:\DATA_Glab';
%mypath='C:\Users\anatk\Documents\Data_Glab_home_work';
%%% tiff files quality is much better here
switch exp
    case 'room_light'
        file_name='LGS_SCN_VIP2';
    case 'red_4e14'
        file_name='LGS_SCN_VIP_red_light';
end


ni=1; % second round seeDB - staining for GFP, so looks better. 
%file_name='LGS_SCN_VIP';ni=1;
%[NUMpar,TXTpar,RAWpar]=xlsread([mypath '\' file_name '.xlsx']);
T=readtable([mypath '\' file_name '.xlsx']);
raw_ind=find(strcmp(T.ID,mouse));
raw_ind=raw_ind(1);

this_path=T.path{raw_ind};
%this_path='Z:\Anat\SCN_rep\Rep_SCN_histology\';
folder=[this_path T.LGSFile_name{raw_ind}];
step=T.VIP(raw_ind); % image step. can be found in Zen image info
num_channel=T.num_channels(raw_ind);
fiber_image_ind=T.fiber_image_ind(raw_ind)-1; % index of image the fiber is best expressed
scn_image_ind=T.scn_image_ind(raw_ind);
%scn_range=RAWpar{raw_ind,12};
min_X=T.min_X_whereSCNStarts_ForImage_(raw_ind);
GFP_ch=T.GFP_ch(raw_ind);



% define the channel we are looking at and the type of file exist in the
% folder
cd (folder);
if exist('ch0');  cd('ch0'); end
all_types={'*.jpeg','*.tiff', '*.tif'};
for ti=1:length(all_types)
    listOfFiles{ti} = dir(all_types{ti});
    if ~isempty(listOfFiles{ti})
        type=all_types{ti};
    end
end
cd (folder);

Factor=0.0;
move_files=1;

%folder='D:\DATA_Glab\Light_sectioning\WT2170\WT2170_processed_confocal\WT2170_GC488_ARC_647_10X_zoom2p5_3um_step_10X.tiff_files';
if exist('SCN_to_fiber_distance.mat')>0
    load('SCN_to_fiber_distance.mat')
    %MAX_GFP_distance_fiber=SCN_to_fiber_distance;
else
    
    if move_files
        for ci=1:num_channel
            dir_ch=ci-1;
            %% read relevant jpegs and move to designated folder and gointo relevnt folder
            move_files_to_folder(folder,dir_ch,type)
        end
    end
    
    
    dir_ch=0;% for GFP
    % go to relevant folder
    cd(['ch' num2str(dir_ch)])
    listOfFiles2 = dir(type);
    for fi=1:length(listOfFiles2)
        if contains(listOfFiles2(fi).name ,['z' num2str(fiber_image_ind) 'c' num2str(dir_ch) 'x0'])
            ind=fi;
        end
    end
    
    tmp_image=imread((listOfFiles2(ind).name)); cd ../
    fiber_image=tmp_image(:,:,2);
    
    
    %% show figure and define coordinates of fiber
    
    brightness_factor=10;
    if exist('fiber_4_coordinates.mat')>0
        load('fiber_4_coordinates.mat')
    else
        
        BrF=[brightness_factor,brightness_factor];
        [Afiber_image, ~]=adjust_brightness(fiber_image,fiber_image,BrF(1),BrF(2),0);
        figure
        imshow(Afiber_image)
        title([mouse ', choose FIBER 4 coordinates, starting 12, clockwise'])
        [x,y] = white_ginput(4); % choose 4 cursors, clock wise, starting 12
        save('fiber_4_coordinates','x','y')
    end
    %% using those input, define center and delta
    Dia=0.5*(abs(x(4)-x(2))+abs(y(3)-y(1)));% calculate diameter
    I2 = imcrop(fiber_image,[min(x)-Dia*Factor/2 min(y)-Dia*Factor/2 Dia*(1+Factor) Dia*(1+Factor)]);
    
    figure
    subplot(1,2,1)
    imshow(fiber_image*brightness_factor)
    subplot(1,2,2)
    imshow(I2*brightness_factor)
    title('check if cropping is good')
    
    %% calculates fluorscence intensity in each channel.
    % use show_image to make sure it is in the desired area
    clear fluor_int
    show_image=0;
    for ci=1:num_channel
        dir_ch=ci-1;
        clear I3 this_image tmp_image BW BWI I3_clean
        cd(['ch' num2str(dir_ch)])
        listOfFiles2 = dir(type);
        %% find background value to substract
        %     tmp_image=imread((listOfFiles2(ind).name));
        %     I4 = imcrop(tmp_image,[min(x)-Dia*Factor/2 min(y)-Dia*Factor/2 Dia*(1+Factor) Dia*(1+Factor)]);
        %     [J, rect] = imcrop(I4);
        %     J=J(:,:,2);
        for fi=1:length(listOfFiles2)
            tmp_image=imread((listOfFiles2(fi).name));
            this_image=tmp_image(:,:,2);
            %         if fi==1 && ci==1
            %             figure;[J, rect] = imcrop(this_image);
            %         else
            %             J=imcrop(this_image,rect);
            %         end
            I3 = imcrop(this_image,[min(x)-Dia*Factor/2 min(y)-Dia*Factor/2 Dia*(1+Factor) Dia*(1+Factor)]);
            level = graythresh(I3);
            BW = imbinarize(I3,level);
            %         level = graythresh(this_image);
            %         BW = imbinarize(this_image,level);
            %         I3 = imcrop(this_image,[min(x)-Dia*Factor/2 min(y)-Dia*Factor/2 Dia*(1+Factor) Dia*(1+Factor)]);
            BWI=uint8(BW);
            if show_image
                figure; subplot(2,2,1); imshow(I3);
                subplot(2,2,2); imshowpair(I3,BW,'montage')
                subplot(2,2,4);imshowpair(I3,BWI.*I3,'montage'); title(['channel ' num2str(ci) ' plane ' num2str(fi)])
            end
            
            I3_clean=BWI.*I3;
            % find the right index (list is not sorted)
            str1=listOfFiles2(fi).name(strfind(listOfFiles2(fi).name,str_to_find)-8:end);
            if fiber_image_ind>1
                %k=str2num(str1(strfind(str1,'z')+1:strfind(str1,'c')-1))+1-fiber_image_ind;
                k=str2num(str1(strfind(str1,'z')+1:strfind(str1,'c')-1))+1;
            else
                k=str2num(str1(strfind(str1,'z')+1:strfind(str1,'c')-1))+1;
                % if k==0; k=k+1; end
            end
            % put into matrix
            fluor_int(ci,k)=sum(sum(I3_clean));
        end
        cd ../
    end
    % create x and normalize fluor_int
    clear norm_fluor_int X
    for ci=1:num_channel
        cd(['ch' num2str(dir_ch)])
        listOfFiles2 = dir(type);
        dir_ch=ci-1;
        X(ci,:)=[0:step:(length(listOfFiles2)-1)*step];
        norm_fluor_int(ci,:)=fluor_int(ci,:)./max(fluor_int(ci,:));
        cd ../
    end
    %X=mean(X);
    
    
    figure; subplot(2,1,1); h=bar(X(1,:)',norm_fluor_int(1,:)');
    h(1).FaceColor =[0, 0.5, 0];% h(2).FaceColor =[0, 0.4470, 0.9410]; %h(3).FaceColor =[0.50, 0.50, 0.50];
    title(mouse); xlabel('depth (um)'); ylabel ('Normalized dF (a.u.)')
    %xlim([min_X max(mean(X))])
    subplot(2,1,2); h=bar(X(1,:)',fluor_int(1,:)');
    h(1).FaceColor =[0, 0.5, 0]; %h(2).FaceColor =[0, 0.4470, 0.9410]; %h(3).FaceColor =[0.50, 0.50, 0.50];
    xlabel('depth (um)'); ylabel ('dF (a.u.)')
    % xlim([min_X max(mean(X))])
    title([mouse ' ,choose GFP max'])
    [x_max,y_max] = ginput(1); % choose 4 cursors, clock wise, starting 12
    
    1
    
    if size(X,1)>2
        figure; subplot(2,1,1); h=bar(X',norm_fluor_int');
        h(1).FaceColor =[0, 0.5, 0]; h(2).FaceColor =[0, 0.4470, 0.9410]; h(3).FaceColor =[0.5, 0.5, 0.5];
        title(mouse); xlabel('depth (um)'); ylabel ('Normalized dF (a.u.)')
        xlim([min_X max(mean(X))])
        subplot(2,1,2); h=bar(X',fluor_int');
        h(1).FaceColor =[0, 0.5, 0]; h(2).FaceColor =[0, 0.4470, 0.9410]; h(3).FaceColor =[0.5, 0.5, 0.5];
        xlabel('depth (um)'); ylabel ('dF (a.u.)')
        xlim([min_X max(mean(X))])
    end
    
    %[val,ind]=max(fluor_int(GFP_ch,:));
    MAX_GFP_distance_fiber=RI*abs(fiber_image_ind*step-round(x_max,2,'significant'));
    save('SCN_to_fiber_distance','MAX_GFP_distance_fiber')
end


%% define SCN rectangle
% added 051923 AK - check if all works well!
 dir_ch=0;% for GFP
    % go to relevant folder
    cd(['ch' num2str(dir_ch)])
    listOfFiles2 = dir(type);
    for fi=1:length(listOfFiles2)
        if contains(listOfFiles2(fi).name ,['z' num2str(scn_image_ind) 'c' num2str(dir_ch) 'x0'])
            ind=fi;
        end
    end
    
    tmp_image=imread((listOfFiles2(ind).name)); cd ../
    scn_image=tmp_image(:,:,2);
% cd ../
if exist('scn_coordinates.mat')
    disp('scn coordinates exist')
else
    ci=1;
    figure
    imshow(scn_image)
    title(['choose 2 coordinates of middle SCN , starting at the bottom'])
    [x,y] = white_ginput(2); % choose 2 cursors, starting bottom
    save('scn_coordinates','x','y') %
end
