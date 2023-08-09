% test response significant difference between GCaMP and GFP lumencore 
analysis='all_peak_intensity'
analysis='resp'
 
cd('Z:\Anat\Papers_in_work_from_laptop\SCN_VIP_LightResponse')

GCaMP_resp=load(['lumencore_GCaMP_' analysis '_SCNVIP.mat']);
GFP_resp=load(['lumencore_GFP_' analysis '_SCNVIP.mat']);
GCaMP_resp_red_high=load('red_high_GCaMP_all_peak_intensity_SCNVIP.mat');
GCaMP_resp_red_high.resp=nonzeros(GCaMP_resp_red_high.resp);

red_ind=7;

switch analysis
    case 'all_peak_intensity'
        GCaMP_resp.resp=GCaMP_resp.all_peak_intensity;
        GFP_resp.resp=GFP_resp.all_peak_intensity;
end


for i=1:7 % 7 colors in lumencore experiment
    [h(i),p(i)]=ttest2(GCaMP_resp.resp(i,:),GFP_resp.resp(i,:));
end

x=[GCaMP_resp_red_high.resp; GFP_resp.resp(red_ind,:)'];
g=[ones(length(GCaMP_resp_red_high.resp),1); 2*ones(length(GFP_resp.resp(red_ind,:)),1) ];
boxplot(x,g)

[h_red,p_red]=ttest2([GCaMP_resp_red_high.resp],GFP_resp.resp(red_ind,:)');
1