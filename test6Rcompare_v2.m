function test6Rcompare_v2
% new version, May 2023 Matlab R2020b AK
% edited for iScience SCN-VIP
clear MAX_GFP_distance_fiber peak_areas peak_heights distance_fiber_scn_center total_cells_under_fiber
clear all_ID df t 
condition='red_4e14';% red_6e14 or  room_light or red_4e14


interval=1;

%par_file_name='LGS_SCN_VIP2';
switch condition
    case 'room_light'
        par_file_name='LGS_SCN_VIP';% this file has the original images, before re-staining, so the distances are more accurate
        session_name='test6R1';
        light_intensity_group=1; 
    case 'red_6e14'
        par_file_name='LGS_SCN_VIP_red_light';% this file has the original images, before re-staining, so the distances are more accurate
        session_name='test6R1';% check this- it will need to be repkaced 051823
        light_intensity_group=2; %check xlsx sheet to see group seperation 
    case 'red_4e14'
        par_file_name='LGS_SCN_VIP_red_light';% this file has the original images, before re-staining, so the distances are more accurate
        session_name='test6R1';% check this- it will need to be repkaced 051823
        light_intensity_group=3; %check xlsx sheet to see group seperation 

end
%mypath2='C:\Users\anatk\Documents\Data_Glab_home_work\'; 
mypath2='D:\DATA_Glab\';
T=readtable([mypath2 par_file_name '.xlsx']);
%ID={'VIPGC62L','VIPGC107R','VIPGC110LL','VIPGC106LL','VIPGC113L','VIPGC115L','VIPGC118RR','VIPGC123L','VIPGC128R'};
%last=31;
all_ID=T.ID;
%include=NUMSCN(3:end,1);
%ind=find(include)+2; % start to read num from the 3rd raw
%all_ID=all_ID(ind);
rig=T.test6RSystem;
side=T.reocrdedSide;
dates=T.test6RDate;
Sess=1;% doesn't metter
Sname=T.Sname; %Sname=Sname(ind);
Sex=T.sex;
Estrus_states='na';
MinPeakP=1.2



switch condition
    case 'room_light'
        inds=find(strcmp(Sname,session_name));
    case 'red_6e14'
        LiGS_availability=T.LiGS_availability;
        group=T.group;
        inds=intersect(find(group==light_intensity_group),find(LiGS_availability));
    case 'red_4e14'
        group=T.group;
        inds=intersect(find(group==light_intensity_group),find(strcmp(Sname,session_name)));

end
% 
k=0;
for si=1:length(inds)
   % if strfind(Sname{si},'test6R')
        %(ID,side,date,Sess,Sname,Gender,Estrus,rig,MinPeakP,interval,bins,thresh)
        %if strcmp(Sname{si},session_name)
            k=k+1;
            disp (all_ID{inds(si)})
            [data] = FP_analysis_individual_v4(all_ID{inds(si)},side{inds(si)},dates{inds(si)},Sess,Sname{inds(si)},Sex{inds(si)},Estrus_states,rig{inds(si)},MinPeakP,interval)
            df{k}=data.dF;
            mean_dF(k,:)=data.mean_test_df;
            mean_t(k,:)=data.mean_test_t;
            % Data{si}=data.Data;
            t{k}=data.t;
            peak_analysis{k}=data.peak_analysis;
            included_ID{k}=all_ID{inds(si)};
      %  end
%     else
%         peak_analysis{si}=[];
%         df{si}=[];
%         t{si}=[];
%     end
end
 

figure
for si=1:length(df)
    if ~isempty(df{si})
    ph=plot(t{si},df{si}(1,:));
    set(ph,'linewidth',2);
    hold on
    end
end
xlabel('Time (sec)','FontSize',12);
ylabel('dF/F (%)','FontSize',12);
title('VIPXAi162 SCN-VIP fiberphotometry','Fontsize',14)
legend({'full light', 'red light'})

close all
%% get peak_analysis 
for si=1:length(included_ID)
    if ~isempty(peak_analysis{si})
       peak_heights(si)=peak_analysis{si}.peaks_height;
       peak_areas(si)=peak_analysis{si}.peaks_area; % peak intensities : p x w
%     elseif strfind(all_ID{si},'VIPGC102L')
%         peak_heights(si)=1.5; peak_areas(si)=peak_heights(si)*107;% only 'test' is available. by inspection during recording 
%     elseif strfind(all_ID{si},'VIPGC103R')
%         peak_heights(si)=6;  peak_areas(si)=peak_heights(si)*107;% only 'test' is available. by inspection during recording 
%     elseif strfind(all_ID{si},'VIPGC108L')
%         peak_heights(si)=7; peak_areas(si)=peak_heights(si)*107;% only 'test' is available. by inspection during recording\
%     elseif strfind(all_ID{si},'VIPGC108L')
%         peak_heights(si)=5.97; peak_areas(si)=73.5;% only 'test' is available. by 1 repeat
%  
    else
       peak_heights(si)=nan; 
       peak_areas(si)=nan;
    end
end

w=[];
width=peak_areas./peak_heights;
for wi=1:length(width)
    if width(wi)>0
        w=[w width(wi)];
    end
end
nanmean(w)

switch condition
    case 'red_4e14'
        cd ('Z:\Anat\Papers_in_work_from_laptop\SCN_VIP_LightResponse')
        resp=peak_areas;
        save(['red_high_GCaMP_all_peak_intensity_SCNVIP'],'resp')
end
%% get distances between SCN max to fiber 
for si=1:length(included_ID)
    disp(['Ind=' num2str(si) ' ' included_ID{si}])
    MAX_GFP_distance_fiber(si)=find_fluor_exp_above_fiber_v2(included_ID{si},condition);
end


% get distance from fiber center to scn center - this value is more
% accurate 
for si=1:length(included_ID)
    disp(['Ind=' num2str(si) ' ' included_ID{si}])
    distance_fiber_scn_center(si)=find_distance_fiber_to_target(included_ID{si},condition);
end

% is air lens
distance_to_use_for_normalization='fiber to scn center distance';
%distance_to_use_for_normalization='fiber to max expression under fiber';
switch distance_to_use_for_normalization
    case 'fiber to scn center distance'; distance=distance_fiber_scn_center;
    case 'fiber to max expression under fiber';   distance=MAX_GFP_distance_fiber;
end

% based on Shy Shoham (Yona et al, eNeuro 2016)
meu_s=168.6; % cm-1
%meu_s=120; %cm-1
distance_cm=distance'.*10^-4;
for idi=1:length(distance_cm)
    % norm by distnace
    norm_df(idi,:)=mean_dF(idi,:)*exp(meu_s.*distance_cm(idi));
    % z scored
       this_median=median(mean_dF(idi,:));
       this_mad=mad(mean_dF(idi,:),1);
       z_scored_df(idi,:) = (mean_dF(idi,:) - this_median)./this_mad; % normalization using robust z-score
end

% normalize 
df_max=max(nanmean(mean_dF)); % normalization factor based on mean 
zscore_max=max(nanmean(z_scored_df));
norm_max=max(nanmean(norm_df));
mean_dF=mean_dF/df_max;
z_scored_df=z_scored_df/zscore_max;
norm_df=norm_df/norm_max;


% calculates var 
norm_var=var(norm_df(:,:));
zscore_var=var(z_scored_df(:,:));
df_var=var(mean_dF(:,:));
% calculates var when removing samples at a specific interval
clear mean_df_var mean_zscore_var mean_norm_var tmp_df tmp_zscore tmp_norm

%par_file_name='LGS_SCN_VIP2';
switch condition
    case 'room_light'

for ri=1:20
    rand_samples(ri,:)=randperm(11);
    for i=1:10
        tmp_df=mean_dF(rand_samples(:,1:11-i)',300:600);
        tmp_zscore=z_scored_df(rand_samples(:,1:11-i)',300:600);
        tmp_norm=norm_df(rand_samples(:,1:11-i)',300:600);
        mean_df_var(ri,i)=mean(var(tmp_df));
        mean_zscore_var(ri,i)=mean(var(tmp_zscore));
        mean_norm_var(ri,i)=mean(var(tmp_norm));
    end
end
end

% plot normalized dF valused, norm using z-score or distnace 
figure;
t_all=nanmean(mean_t);

subplot(3,2,1)
% plot(t_all,mean(mean_dF)+std(mean_dF)/sqrt(size(mean_dF,1)),'k');hold on;
% plot(t_all,mean(mean_dF)-std(mean_dF)/sqrt(size(mean_dF,1)),'k');hold on;
plot(t_all,mean_dF,'k');hold on;
plot(t_all,nanmean(mean_dF),'r','linewidth',4); hold on;
ylabel ('dF/F') 
ylim([-0.25 2.5])
xlim([8 37])

subplot(3,2,3) 
% plot(t_all,mean(z_scored_df)+std(z_scored_df)/sqrt(size(z_scored_df,1)),'k')
% plot(t_all,mean(z_scored_df)-std(z_scored_df)/sqrt(size(z_scored_df,1)),'k')
plot(t_all,z_scored_df,'k');hold on;
plot(t_all,nanmean(z_scored_df),'g','linewidth',4); hold on;
ylabel (['z scored dF/F']) 
ylim([-0.25 2.5])
xlim([8 37])

subplot(3,2,5)
% plot(t_all,mean(norm_df)+std(norm_df)/sqrt(size(norm_df,1)),'k')
% plot(t_all,mean(norm_df)-std(norm_df)/sqrt(size(norm_df,1)),'k')
plot(t_all,norm_df,'k');hold on;
plot(t_all,nanmean(norm_df),'b','linewidth',4); hold on;
ylabel ('dF/F normalized to distance') 
xlabel ('time (sec)')
ylim([-0.25 2.5])
xlim([8 37])

subplot(3,2,2)
plot(t_all,df_var,'r'); hold on;
plot(t_all,zscore_var,'g'); hold on;
plot(t_all,norm_var,'b'); hold on;
xlabel ('time (sec)') 
ylabel ('Varience') 
ylim([-0.05 0.5])
xlim([8 37])

[P,t,stat] = kruskalwallis([df_var(300:599) zscore_var(300:599) norm_var(300:599)],[ones(1,300) 2*ones(1,300) 3*ones(1,300)],'off');
c=multcompare(stat);


switch condition
    case 'room_light'
subplot(3,2,4)
x=[1:10];
y1=mean(mean_df_var,1);sem=std(mean_df_var,1)/sqrt(size(mean_df_var,1));
plot(x,y1,'-*r'); hold on;
er=errorbar(x,y1,sem,sem); er.Color=[0 0 0]; er.LineStyle='none'; hold on;
y2=mean(mean_zscore_var,1);sem=std(mean_zscore_var,1)/sqrt(size(mean_zscore_var,1));
plot(x,y2,'-*g'); hold on;
er=errorbar(x,y2,sem,sem); er.Color=[0 0 0]; er.LineStyle='none'; hold on;
y3=mean(mean_norm_var,1);sem=std(mean_norm_var,1)/sqrt(size(mean_norm_var,1));
plot(x,y3,'-*b'); hold on;
er=errorbar(x,y3,sem,sem); er.Color=[0 0 0]; er.LineStyle='none'; hold on;
xlim([0 12])
xlabel('# samples removed')
ylabel ('mean varience during response') 

end
% get number of cells under fiber. reads from xlsx file- that was created
% using 'cell_quantification_Zsatck_assistance', which uses 'count_cell'-
% give astimation- should check figures to make sure the numbers are ok
mypath='D:\DATA_Glab\'

get_scn_cell=0;
total_cells_under_fiber=[];
if get_scn_cell
    %par_file_name='SCN quantification3';
    par_file_name='SCN quantification2_readtable_format';
    T=readtable([mypath par_file_name]);
    %[NUMcellq,TXTcellq,RAWcellq]=xlsread([mypath par_file_name '.xlsx']);
    raw_ind=[];
    for si=1:length(included_ID)
        clear raw_ind raw_total_ind
        %raw_ind=find(strcmp(RAWcellq(:,1),included_ID{si}));
        raw_ind=find(strcmp(T.ID,included_ID{si}));
        if ~isempty(raw_ind)
            %raw_total_ind=min(find(strcmp(T.t(raw_ind),'total')))+raw_ind-1;
            %total_cells_under_fiber(si)=0.5*(RAWcellq{raw_total_ind,2}+RAWcellq{raw_total_ind,3});% mean over two counts, by 2 people
            total_cells_under_fiber(si)=T.num_of_cells_under_fiber(raw_ind);
        else
            total_cells_under_fiber(si)=nan;
        end
    end
end
fiber_dia=400;
NA=0.48;
n=1.335;
Z0=fiber_dia/(2*tan(NA/n));

% calculating the right distance based on SeeDB index refrection, and lens
% is air lens
distance_to_plot=distance_to_use_for_normalization;
%distance_to_plot='fiber to max expression under fiber';
switch distance_to_plot
    case 'fiber to scn center distance'; plot_distance=distance_fiber_scn_center;
    case 'fiber to max expression under fiber';   plot_distance=MAX_GFP_distance_fiber;
end

disp(['N=' num2str(length(find(plot_distance<1000)))])

plot_val='peak area';
%plot_val='peak amplitude';
switch plot_val
    case 'peak area'; data_to_plot=peak_areas;
    case 'peak amplitude'; data_to_plot=peak_heights;
end

% plot 3D
% 
% figure;
% %plot3(plot_distance,total_cells_under_fiber,peak_areas,'o'); 
% plot(peak_areas,plot_distance,'o'); 
% hold on
% plot(total_cells_under_fiber,peak_areas,'o'); 
% figure;
% imagesc(plot_distance,total_cells_under_fiber,peak_areas)
% % plot 2D 
plot_fit=1;
switch condition
    case 'room_light'
        plot_distance2=plot_distance;
        data_to_plot2=data_to_plot;
        %plot_distance2=plot_distance([1:2,4,6:length(plot_distance)]);
        %data_to_plot2=data_to_plot([1:2,4,6:length(data_to_plot)]);
    case 'red_4e14'
        plot_distance2=plot_distance;
        data_to_plot2=data_to_plot;
end

figure
[f,gof] = fit(plot_distance2',data_to_plot2','exp1'); % peak area
if plot_fit; plot(f,plot_distance2,data_to_plot2); hold on; end
plot(plot_distance2,data_to_plot2,'.g','MarkerSize',14)
%plot(MAX_GFP_distance_fiber,peak_areas,'.')
ylabel(plot_val)
xlabel([distance_to_plot ' (um)'])
title(['R square = ' num2str(gof.rsquare)]);
xlim([100 1.2*max(plot_distance2)])
ylim([0.6*min(data_to_plot2) 1.2*max(data_to_plot2)])

%%
 plot_fit=1;
figure
subplot(1,3,1)
[f,gof] = fit(plot_distance',data_to_plot','exp1');
if plot_fit; plot(f,plot_distance,data_to_plot); hold on; end
plot(plot_distance,data_to_plot,'.g')
%plot(MAX_GFP_distance_fiber,peak_areas,'.')
ylabel(plot_val)
xlabel([distance_to_plot ' (um)'])
title(['R square = ' num2str(gof.rsquare)]);

xlim([0 max(plot_distance)*1.2])
ylim([0 1.2*max(data_to_plot)])

if ~isempty(total_cells_under_fiber)
    subplot(1,3,2)
    %[f,gof] = fit(total_cells_under_fiber',peak_areas','exp1');
    %linear fit
    x=total_cells_under_fiber';
    y=data_to_plot';
    b1 = x\y;
    yCalc1 = b1*x;
    Rsq1 = 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2);
    if plot_fit; plot(x,yCalc1); end
    hold on
    plot(total_cells_under_fiber,data_to_plot,'.g')
    set(gca,'XDir','reverse')
    %plot(total_cells_under_fiber,peak_areas,'.')
    
    ylabel(plot_val)
    %ylabel('peak area/num cells')
    xlabel('number of cells under fiber')
    title(['R square = ' num2str(Rsq1)]);
    
    subplot(1,3,3)
    plot(plot_distance./total_cells_under_fiber,data_to_plot,'.')
    xlabel('distance norm to cell counts')
    ylabel(plot_val)

xlim([0 max(total_cells_under_fiber)*1.2])
ylim([0 1.2*max(data_to_plot)])
end

% subplot(2,2,3)
% [f,gof] = fit(distance_fiber_scn_center',peak_areas','exp1');
% %plot(f,distance_fiber_scn_center,peak_areas)
% plot(distance_fiber_scn_center,peak_areas,'.')
% ylabel('peak area')
% %ylabel('peak area/num cells')
% xlabel('distance fiber from center (um)')
% %title(['R square = ' num2str(gof.rsquare)]);
% 
% subplot(2,2,4)
% distance=sqrt(distance_fiber_scn_center.^2+MAX_GFP_distance_fiber.^2);
% [f,gof] = fit(distance',peak_areas','exp1');
% plot(distance,peak_areas,'.')
% %plot(f,distance,peak_areas)
% ylabel('peak area')
% %ylabel('peak area/num cells')
% xlabel('combined distance (um)')
% %title(['R square = ' num2str(gof.rsquare)]);



1