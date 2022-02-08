% spectrum, taken with ocean optics 
my_path='D:\DATA_Glab\fiberphotometry\';
[num,txt]=xlsread([my_path 'Ocean_optics_roomand_red_light.xlsx']);
data2(1,:)=num(5:end,1);% wavelength in nm
data2(2,:)=num(5:end,3);% red light
data2(3,:)=num(5:end,4);% room light

[num,txt]=xlsread([my_path 'ocean optics_room_light_Chen']);
data3(1,:)=num(5:end,1);% wavelength in nm
data3(2,:)=num(5:end,3);% room light Chen

[num,txt]=xlsread([my_path 'ocean optics_red_light_Chen']);
data4(1,:)=num(5:end,1);% wavelength in nm
data4(2,:)=num(5:end,3);% room light Chen

figure
%subplot(1,2,1)
plot(data2(1,:),data2(2:3,:));hold on;
%subplot(1,2,2)
plot(data3(1,:),data3(2,:));hold on;
plot(data4(1,:),data4(2,:));hold on;
xlabel('wavelength (nm)')
xlim([ 300 800])
legend({'Alles white', 'Alles red', 'Chen white', 'Chen red'}) 
