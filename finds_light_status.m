function [light_array]=  finds_light_status(files1,all_dF,Sname,t1,fs)
% x was added for red light stimulus 111720 AK

switch files1

      case '082418' %% TTL was not connected
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs;
         light_array.exp='DL';
    case {'VIPGC113L_Rfiber_053119_DL1','VIPGC106LL_Rfiber_050619_DL1','VIPGC62L_Rfiber_122718_DL4','VIPGC62L_Rfiber_122618_DL3','VIPGC62L_Rfiber_122518_DL2','VIPGC62L_Rfiber_122418_DL1','VIPGC60N_Rfiber_041019_DLold1','VIPGC60N_Rfiber_040919_DLold0','VIPGC62L_Rfiber_041019_DLold1','VIPGC25L_Lfiber_040519_DLold3', 'VIPGC25L_Lfiber_041619_DLold6','VIPGC25L_Lfiber_040419_DLold2'}%% TTL was not working
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs;
         light_array.exp='DL';
    case {'VIPGC115L_Rfiber_070819_DL9','VIPGC115L_Rfiber_070219_DL7','VIPGC60N_Rfiber_122018_DL5','VIPGC60N_Rfiber_121918_DL4','VIPGC60N_Rfiber_121818_DL3'}%,'VIPGC60N_Rfiber_121718_DL2','VIPGC60N_Rfiber_121118_DL1'}%% TTL was not working
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs;
         light_array.exp='DL';
     case {  'VIPGC128R_Rfiber_081219_DL8','VIPGC119LL_Rfiber_080119_DL4','VIPGC128R_Rfiber_080619_DL5','VIPGC115L_Rfiber_070519_DL8','VIPGC68RL_Lfiber_010719_DL1','VIPGC25L_Lfiber_091118_DL0','VIPGC25L_Lfiber_110518_DL1'}%% TTL was not working
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs;
         light_array.exp='DL';
    case {'VIPGC60N_Rfiber_121718_DL2'}%% TTL was not working
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs+240;
         light_array.exp='DL';
    case {'VIPGC60N_Rfiber_121118_DL1'}
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs+180;
         light_array.exp='DL';
    case {'VIPGC106LL_Rfiber_052019_DL6'}
         light_array.light_off=1;
         light_array.light_on=1800-t1/fs+120;
         light_array.exp='DL';
    case { 'VIPGCA116R_Lfiber_062519_Sess1'}
         light_array.light_off=4860-t1/fs;
         light_array.light_on=1;
         light_array.exp='LD';   
    case { 'VIPGC128R_Rfiber_070219_Sess5'}
         light_array.light_off=5220-t1/fs;
         light_array.light_on=1;
         light_array.exp='LD';  
    case {'VIPGC166R_Rfiber_060220_Sess31','VIPGC166R_Rfiber_050220_Sess30','VIPGC166R_Rfiber_040220_Sess29','VIPGC166R_Rfiber_030220_Sess28','VIPGC166R_Rfiber_020220_Sess27','VIPGC166R_Rfiber_012720_Sess26','VIPGC166R_Rfiber_012920_Sess25','VIPGC166R_Rfiber_012820_Sess24','VIPGC166R_Rfiber_012720_Sess23','VIPGC166R_Rfiber_012620_Sess22','VIPGC166R_Rfiber_012420_Sess21','VIPGC166R_Rfiber_012320_Sess20','VIPGC166R_Rfiber_012220_Sess19','VIPGC166R_Rfiber_012120_Sess18','VIPGC166R_Rfiber_012020_Sess17','VIPGC166R_Rfiber_011920_Sess16','VIPGC176RL_Lfiber_010920_Sess34','VIPGC176RL_Lfiber_010820_Sess33','VIPGC176RL_Lfiber_010720_Sess32','VIPGC176RL_Lfiber_010620_Sess31','VIPGC161RR_Rfiber_122719_Sess7','VIPGC161RR_Rfiber_122619_Sess6','VIPGC161RR_Rfiber_122519_Sess5','VIPGC161RR_Rfiber_122419_Sess4','VIPGC161RR_Rfiber_122319_Sess3','VIPGC161RR_Rfiber_122219_Sess2','VIPGC161RR_Rfiber_122019_Sess1','VIPGC128R_Rfiber_111919_Sess15','VIPGC128R_Rfiber_111819_Sess14','VIPGC128R_Rfiber_111419_Sess13','VIPGC128R_Rfiber_111319_Sess12','VIPGC128R_Rfiber_100319_Sess8','VIPGC128R_Rfiber_100219_Sess7','VIPGC128R_Rfiber_092619_Sess5','VIPGC128R_Rfiber_092519_Sess4','VIPGC128R_Rfiber_092419_Sess3','VIPGC128R_Rfiber_092319_Sess2','VIPGC122R_Rfiber_091919_Sess9','VIPGC123L_Rfiber_091919_Sess10','VIPGCA116R_Lfiber_091919_Sess6','VIPGC122R_Rfiber_091719_Sess7','VIPGCA116R_Lfiber_091219_Sess2','VIPGCA116R_Lfiber_091119_Sess1','VIPGC123L_Rfiber_090319_Sess3','VIPGC123L_Rfiber_090219_Sess2','VIPGC119LL_Rfiber_091019_Sess2','VIPGC119LL_Rfiber_090919_Sess1','VIPGC123L_Rfiber_082719_Sess1', 'VIPGC115L_Rfiber_080719_Sess6','VIPGC107R_Rfiber_080819_Sess6','VIPGC128R_Rfiber_070319_Sess6','VIPGC128R_Rfiber_063019_Sess4','VIPGC128R_Rfiber_062819_Sess2','VIPGC62L_Rfiber_120418_Sess3','VIPGC25L_Lfiber_030519_LDold4','VIPGC25L_Lfiber_030619_LDold5','VIPGC25L_Lfiber_030719_LDold6'}%% TTL was not connected
         light_array.light_off=3600-t1/fs;
         light_array.light_on=1;
         light_array.exp='LD';
    case {'VIPGC25L_Lfiber_030819_LDold7'}%% TTL was not connected
         light_array.light_off=2880-t1/fs;
         light_array.light_on=1;
         light_array.exp='LD';
    case 'VIPGC18N_Rfiber_082718_Sess5'%% TTL is wrong
      light_array.light_off=3600-t1/fs;
      light_array.light_on=1;
      light_array.exp='LD';
    case 'VIPGC18N_Rfiber_082418_Sess2' %% TTL was not connected
      light_array.light_off=3720-t1/fs;
      light_array.light_on=1;
      light_array.exp='LD';
    case 'VIPGC18N_Rfiber_082318_Sess1'%% TTL was not connected
     light_array.light_off=3420-t1/fs;
      light_array.light_on=1;
      light_array.exp='LD';
     case {'VIPGC113L_Rfiber_062319_Sess1','VIPGC12LL_Lfiber_091318_Sess2','VIPGC12LL_Lfiber_101518_Sess12','VIPGC12LL_Lfiber_110218_Sess17','VIPGC60N_Lfiber_031419_LDold1'} %% TTL is wrong
      light_array.light_off=3600-t1/fs;
      light_array.light_on=1;
      light_array.exp='LD';
      otherwise
    light_array=find_light_status_by_figure(all_dF,Sname,files1);
end 
return
