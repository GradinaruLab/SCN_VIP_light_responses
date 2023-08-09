function [z,per_Positive]=find_fluor_quantification_zstack(mouse)
%% to run this FUNCTION save as tiff in Zen
%% CAN BE USED individually or with 'get_gfap_over_samples'
%
% use this as a helper to count cells. works well for vipGC and vIPGFP.
% but have to be carefull and observe. works well in ~50-60% of images
clear ALL_ch_images ALL_BW_ch_images all_BW_ch_images x y 


if nargin == 0
    %%% set parameters
   mouse='VIPGFP11N'
 % mouse='VIPGFP14RL'
    
    %mouse='VIPGC106LL'
   % mouse='VIPGC107'
    %mouse='VIPGC110L'
  % mouse='VIPGC113L'
   % mouse='VIPGC115L'
  % mouse='VIPGC118R'
   %mouse='VIPGC119L'
    %mouse='VIPGC122R'
    %mouse='VIPGC123L'
   % mouse='VIPGC128R'
    %mouse='VIPGC129L'
    %mouse='VIPGC162'
end

show_correlated_figure=0
show3D_fig=0
scn_size=450;% in microns
image_pixel_size=2048;
image_size=850.19;% in microns
scn_pixel_size=image_pixel_size*scn_size/image_size;
count_GFP=0
count_GFAP_pixels=1
if exist('ch0')
    move_files=0;
else
    move_files=1;
end

str_to_find='-2048y0';

my_path='C:\Users\anatk\Documents\Data_Glab_home_work';
%my_path='D:\DATA_Glab';
%%% tiff files quality is much better here
switch mouse
    case 'VIPGFP11N'
        folder=[my_path '\Histology\Rep_SCN\VIPGFP11N_GFP_GFAB555_Esr1647\VIPGFP11N_GFP_GFAP555_Esr1647_SCN_10umstep_10X_zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=20; % index of image scn is best expressed
         scn_range=[5:27];
      
    case 'VIPGFP12R'
        folder=[my_path '\Histology\Rep_SCN\VIPGFP12R_Esr1_LGS\VIPGFP12R_Esr1647_10umstep_10X_Zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=2;
        scn_image_ind=26; % index of image scn is best expressed
         scn_range=[17:33];
      

    case 'VIPGFP14RL'
        folder=[my_path '\Histology\Rep_SCN\VIPGFP14RL_F_LGS_PR_GFAB\VIPGFP14RL_F_555GFAP_647PR_10umstep_10X.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        scn_image_ind=16; % index of image where scn is the best
         scn_range=[7:22];
        num_channel=3;
    case 'VIPGC106LL'
        folder=[my_path '\Histology\Rep_SCN\VIPGC106LL_M_LGS\VIPGC_106LL_488GC_555GFAP_647PR_10umstep_10X.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=15;% index of image where the fiber is seen first
         scn_range=[9:17];
        %min_X=0;% to be defined later
    case 'VIPGC107R'
        folder=[my_path '\Histology\Rep_SCN\VIPGC107_OVX_GFP_GFAB555_Esr1647\VIPGC107_OVX_10umstep_10X_zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=14; % index of image scn is best expressed
        min_X=0; % where SCN starts- for figure
        scn_range=[6:15];
    case 'VIPGC110L'
        folder=[my_path '\Histology\Rep_SCN\VIPGC110LL_F_GFP_GFAP555_PR647\VIPGC110LL_F_GFP_GFAP555_PR647_zstack_10Xb.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=26; % index of image scn is best expressed
         scn_range=[22:34];
        min_X=0; % where SCN starts- for figure
    case 'VIPGC113L'
        folder=[my_path '\Histology\Rep_SCN\VIPGC113L_M_GFP_GFAP555_PR647\VIPGC113L_M_GFP_GFAP555_PR647_zstack_10X.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=16; % index of image scn is best expressed
        min_X=0; % where SCN starts- for figure
    case 'VIPGC115L'
        folder=[my_path '\Histology\Rep_SCN\VIPGC115_OVX_GFP_GFAB555_Esr1647\VIPGC115_OVX_10um_step_10X_zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=24; % index of image scn is best expressed
        scn_range=[15:30];
        min_X=0; % where SCN starts- for figure
    case 'VIPGC118R'
        folder=[my_path '\Histology\Rep_SCN\VIPGC118R_Esr1_LGS\VIPGC118RR_10X_Zstack_647Esr1.tiff_files'];
        step=11.51; % image step. can be found in Zen image info
        num_channel=2;
        scn_image_ind=16;% index of image where the fiber is seen first
        min_X=0;% to be defined later
        
    case 'VIPGC119L'
        folder=[my_path '\Histology\Rep_SCN\VIPGC119L_OVX_GFP_GFAB555_Esr1647\VIPGC119L_OVX_GFP_GFAP555_Esr1647_zstack_10X.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=15; % index of image scn is best expressed
        min_X=0; % where SCN starts- for figure
    case 'VIPGC122R'
        folder=[my_path '\Histology\Rep_SCN\VIPGC122_OVX_GFP_GFAB555_PR647\VIPGC122_OVX_10um_step_10X_zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=16; % index of image scn is best expressed
    case 'VIPGC123L'
        folder=[my_path '\Histology\Rep_SCN\VIPGC123L_OVX_GFP_GFAP555_PR647\VIPGC123L_OVX_GFP_GFAP555_PR647_10X_zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=26; % index of image scn is best expressed
    case 'VIPGC128R'
        folder=[my_path '\Histology\Rep_SCN\VIPGC128R_OVX_GFP_GFAB555_PR647\VIPGC128R_OVX_10um_step_10X_zstack.tiff_files'];
        step=10.0; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=18; % index of image scn is best expressed
         scn_range=[12:19];
    case 'VIPGC129L'
        folder=[my_path '\Histology\Rep_SCN\VIPGC129L_OVX_GFP_GFAB555_Esr1647\VIPGC129L_OVX_GFP_GFAP555_Esr1647_SCN_10X_zstackb.tiff_files'];
        step=25.11; % image step. can be found in Zen image info
        num_channel=3;
        scn_image_ind=13; % index of image scn is best expressed
        
%     case 'VIPGC162'
%           folder='D:\DATA_Glab\Histology\Rep_SCN\VIPGC162_lowsignal_GFP_GFAB_555_Esr1_647\VIPGC162_GC488_GFAB_555_Esr1_647_10X_zoom0p7_zstack.tiff_files';
%          step=30.92; % image step. can be found in Zen image info
%          num_channel=6;% index of image where the fiber is seen first
%          scn_image_ind=0;%% index of image scn is best expressed
        
        
end
type='*.tiff';

Factor=0.0;


cd (folder)
if move_files
    for ci=1:num_channel
        dir_ch=ci-1;
        %% read relevant jpegs and move to designated folder and gointo relevnt folder
        move_files_to_folder(folder,dir_ch,type)
    end
end

%% put all the tiff files from each channel into one matrix
for ci=1:num_channel
    clear all_BW_ch_images all_ch_images
    dir_ch=ci-1;
    cd ([folder '/ch' num2str(dir_ch)])
    listoffiles=dir('*.tiff');;
    for i=1:length(listoffiles)
        % finds the index of the image
        tmp_image=imread((listoffiles(i).name));
        this_image=tmp_image(:,:,2);
        %switch mouse
         %   case 'VIPGFP14RL'
          %      k=str2num(listoffiles(i).name(strfind(listoffiles(i).name,'_10X')+6:strfind(listoffiles(i).name,['c' num2str(dir_ch) 'x0'])-1))+1;
           % otherwise
                k=str2num(listoffiles(i).name(strfind(listoffiles(i).name,'b0v0t0z')+7:strfind(listoffiles(i).name,['c' num2str(dir_ch) 'x0'])-1))+1;
        %end
        all_ch_images(:,:,k)=this_image;
    end
    ALL_ch_images{ci}=all_ch_images;
    %  ALL_BW_ch_images{ci}=all_BW_ch_images;
    cd ../
end

%% define SCN rectangle
cd ../
if exist('scn_coordiantes.mat')
    scn_coor=open('scn_coordiantes.mat');x=scn_coor.x; y=scn_coor.y;
else
    ci=1;
    figure
    imshow(ALL_ch_images{ci}(:,:,scn_image_ind))
    title('choose 2 coordinates of middle SCN, starting at the bottom')
    [x,y] = white_ginput(2); % choose 2 cursors, starting bottom
    save('scn_coordiantes','x','y')
end

%% count GFP at channel 1 (0 in Zen)
if count_GFP
   [number_cells]= count_cells(x,y,num_channel,ALL_ch_images,scn_pixel_size,step);
end

%% after making sure that GFP counting is working well and xlsx file is updated, it continues to GFAP quantification 
clear per_Positive
if count_GFAP_pixels

    if show_correlated_figure
    cell_count_fig=1
    [scn_z,scn1_cells,scn2_cells]=read_cell_counts(mouse,cell_count_fig);
    end
    clear scn1 scn2 all_scn1_images all_scn2_images all_ch_images scn1_org scn2_org
    for ci=1:num_channel
        % ci=2;
        % all_ch_images=ALL_BW_ch_images{ci};
        all_ch_images_org=ALL_ch_images{ci};
        clear I2
        for i=1:size(all_ch_images_org,3)
            if (y(1)-scn_pixel_size/2)<0; y1=0; else y1=y(1)-scn_pixel_size/2;end
            if (x(1)-scn_pixel_size/2)<0; x1=0; else x1=x(1)-scn_pixel_size/2;end
            scn1_org(:,:,i) = imcrop(all_ch_images_org(:,:,i),[x1 y1 scn_pixel_size scn_pixel_size]);
            
            this_image=scn1_org(:,:,i);
            % creates BW images for each SCN and each plane seperately
            level = graythresh(this_image);
            this_BW = imbinarize(this_image,level);
            scn1(:,:,i)=this_BW;
            clear level this_BW
            if (y(2)-scn_pixel_size/2)<0; y2=0; else y2=y(2)-scn_pixel_size/2;end
            if (x(2)-scn_pixel_size/2)<0; x2=0; else x2=x(2)-scn_pixel_size/2;end
            scn2_org(:,:,i) = imcrop(all_ch_images_org(:,:,i),[x2 y2 scn_pixel_size scn_pixel_size]);
            this_image=scn2_org(:,:,i);
            level = graythresh(this_image);
            this_BW = imbinarize(this_image,level);
            
            scn2(:,:,i)=this_BW;
            clear level this_BW
        end
        if show3D_fig
        figure
        imshow3D(uint8(scn1).*scn1_org)
        figure
        imshow3D(uint8(scn2).*scn2_org)
        end
        all_scn1_images{ci}=scn1;
        all_scn2_images{ci}=scn2;
        all_scn1_images_org{ci}=scn1_org;
        all_scn2_images_org{ci}=scn2_org;
        
        
        for si=1:2 % for 2 scn  % 1 is bottom, 2 is up. head position right always
            clear a
            for i=1:size(all_scn1_images{ci},3)
                clear stats a a_org
                switch si
                    case 1
                        a=all_scn1_images{ci}(:,:,i);
                        a_org=all_scn1_images_org{ci}(:,:,i);
                        
                    case 2
                        a=all_scn2_images{ci}(:,:,i);
                        a_org=all_scn2_images_org{ci}(:,:,i);
                end
                b=uint8(a).*a_org;
                % calculates the sum of fluorscence, normalized to size
                per_Positive(i,ci,si)=sum(sum(b))/(size(b,1)*size(b,2));
                z(i)=step*(i-1);
                
            end
        end
        
    end
   z=z'; 
end
 if show_correlated_figure
figure
subplot(2,1,1)
% scn1
[~,ind_max1]=max(scn1_cells(1,:));
scn_z_max(1)=scn_z(ind_max1);

[AX,H1,H2]=plotyy(z,[per_Positive(:,2,1) nan(length(z),1)],scn_z,[nan(length(scn_z),1) scn1_cells(1,:)'],'line','bar')
set(H1,'Color',[0, 0.4470, 0.9410]) % a
set(H2,'FaceColor',[0, 0.5, 0]) % b
%h2(1).FaceColor =[0, 0.5, 0]; h2(2).FaceColor =[0, 0.4470, 0.9410];h2(3).FaceColor =[0.50, 0.50, 0.50]; 
hold on
plot([scn_z_max(1) scn_z_max(1)],[0 max(max(max(per_Positive)))])
%scn2
subplot(2,1,2)
[~,ind_max2]=max(scn2_cells(1,:));
scn_z_max(2)=scn_z(ind_max2);
[AX,H1,H2]=plotyy(z,[per_Positive(:,2,2) nan(length(z),1)],scn_z,[nan(length(scn_z),1) scn2_cells(1,:)'],'line','bar')
set(H1,'Color',[0, 0.4470, 0.9410]) % a
set(H2,'FaceColor',[0, 0.5, 0]) % b
%h2(1).FaceColor =[0, 0.5, 0]; h2(2).FaceColor =[0, 0.4470, 0.9410];h2(3).FaceColor =[0.50, 0.50, 0.50]; 
hold on
plot([scn_z_max(2) scn_z_max(2)],[0 max(max(max(per_Positive)))])

xlabel('z (um)')
ylabel('integrated intensity')
title(mouse)



 end

 %% inorder to return 647 as ch3 - to fit other imaging 
 if   strcmp(mouse,'VIPGC118R')|| strcmp(mouse,'VIPGFP12R')% no GFAP staining    
        tmp=[per_Positive(:,1,:) per_Positive(:,1,:).*nan per_Positive(:,2,:)];
        per_Positive=tmp;
 end     

 
 
 
 
