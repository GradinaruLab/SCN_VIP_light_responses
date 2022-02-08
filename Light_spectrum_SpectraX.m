% spectrum, taken with ocean optics 
my_path='D:\DATA_Glab\';
[num,txt]=xlsread([my_path 'SCNVIP_light_response_SpectraX_all.xlsx']);

colors_bar=[0.4940, 0.1840, 0.5560;0, 0.4470, 0.7410;0 0.9 0.9;0.0000 0.5020 0.5020 ;0, 0.5, 0;0.8500, 0.3250, 0.0980;1, 0, 0];
clear data2
data2(1,:)=num(5:end,4);% wavelength in nm
%ref_columbs=[9 11 13 16 23 28 40 50]-1;
ref_columbs=[9 11 13 28 40 16   50]-1;
k=0;
for i=2:2+length(ref_columbs)-1
    k=k+1;
    data2(i,:)=num(5:end,ref_columbs(k));% 
end



figure
%subplot(1,2,1)
for i=2:2+length(ref_columbs)-1
    y=data2(i,:)-nanmedian(data2(i,:));
    ph=area(data2(1,:),y/max(y));hold on;
    %ph.Color=colors_bar(i-1,:);
    ph.FaceColor=colors_bar(i-1,:);
end

xlabel('wavelength (nm)')
xlim([ 350 700])
ylim([0 1.1])
legend({'395', '438', '473', '513', '560', '586', '650'}) 
1