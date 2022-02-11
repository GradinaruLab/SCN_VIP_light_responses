function [my_path,states,intensities,g_colors,styles2,Groups,mouse_info]=get_exp_info_test6R_FP_v2(exp)
% used for test6R read FP data


switch exp
    case 'blue_vs_red'
        my_path='D:\DATA_Glab\fiberphotometry\TDT_test6R_opn4_antagonist\';
        % without blue light
        %states={'White light' , 'Opn4 ant. white',  'DMSO','Red light' , 'Opn4 ant. red' };
        % with bluw elight
        states={'White, room 4.49e14' ,'Red, room 2.53E13','650 nm 6.32E14','650 nm 4.03E14' ,'650 nm 1.95E14','650 nm 1.82E14 ' ,'438 nm 1.40E15' ,'438 nm 4.27E14' , '438 nm 3.09E14' '438 nm 1.31E14', '438 nm 6.0E13','438 nm 1.76E13'  };
        %b_states{1}='Before'; b_states{2}='After Opn4 antagonist'; b_states{3}='Before'; b_states{4}='After DMSO';
        intensities=[4.49e14, 2.53E13, 6.32E14, 4.03E14, 1.95E14, 1.82E14 ,1.40E15 ,4.27E14, 3.09E14, 1.31E14, 6.0E13, 1.76E13];
        g_colors={'k', 'm','r','r','r','r' 'b', 'b','b','b','b' 'b','b', 'b','k' 'k'};
        styles2={'k-', 'm-','r--','r-.','r:','r-','b-.', 'b:','b-','b--' 'k-.','k:', 'k--','k:' 'k-.'};
        
        Groups={[1:9],[10:17],[18:21],[22:25],[26:29],[30:33],[34:37],[38:41],[42:45],[46:49],[50:53],[54:57]};%  blue light
        
        
        % full white light
        mouse_info{1}.ID='VIPGC262R';mouse_info{1}.side='R';mouse_info{1}.Gender='M'; mouse_info{1}.rig='TDT_test6R_red';;mouse_info{1}.date='020221';mouse_info{1}.Sname='test6R3';%
        ind=2;mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R3';
        ind=3; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R3';
        ind=4; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R3';
        ind=5; mouse_info{ind}.ID='VIPGC246RL';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R3';
        ind=6; mouse_info{ind}.ID='VIPGC247RRL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R2';
        ind=7; mouse_info{ind}.ID='VIPGC259R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R1';
        ind=8; mouse_info{ind}.ID='VIPGC260L';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R1';
        ind=9; mouse_info{ind}.ID='VIPGC261RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R1';
        
        % room Red light
        ind=10; mouse_info{ind}.ID='VIPGC246RL';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=11; mouse_info{ind}.ID='VIPGC247RRL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=12; mouse_info{ind}.ID='VIPGC259R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=13; mouse_info{ind}.ID='VIPGC260L';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=14; mouse_info{ind}.ID='VIPGC261RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=15; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
        ind=16; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
        ind=17; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
        
        % Red XXhigh light 6.32E14 (100)
        ind=18; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='103121';mouse_info{ind}.Sname='test6RredXXhigh';
        ind=19; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='103121';mouse_info{ind}.Sname='test6RredXXhigh';
        ind=20; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='103121';mouse_info{ind}.Sname='test6RredXXhigh';
        ind=21; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RredXXhigh';
        
        % Red high light 4.03E14 (67)
        ind=22; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredhigh';
        ind=23; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredhigh';
        ind=24; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6Rredhigh';
        ind=25; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredhigh';
        
        % Red low light 1.95E14 (44)
        ind=26; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredlow';
        ind=27; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredlow';
        ind=28; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6Rredlow';
        ind=29; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredlow';
        
        
        % Red  Xlow light 1.82E14 (30)
        ind=30; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RredXlow';
        ind=31; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RredXlow';
        ind=32; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RredXlow';
        ind=33; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RredXlow';
        
        
        % blue XXhigh light
        ind=34; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RblueXXhigh';
        ind=35; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RblueXXhigh';
        ind=36; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RblueXXhigh';
        ind=37; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102821';mouse_info{ind}.Sname='test6RblueXXhigh';
        
        % blue Xhigh light
        ind=38; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6RblueXhigh';
        ind=39; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102121';mouse_info{ind}.Sname='test6RblueXhigh';
        ind=40; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6RblueXhigh';
        ind=41; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6RblueXhigh';
        
        % blue high light
        ind=42; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluehigh';
        ind=43; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluehigh';
        ind=44; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6Rbluehigh';
        ind=45; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6Rbluehigh';
        %  blue Xmed light
        ind=46; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6RblueXmed';
        ind=47; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102121';mouse_info{ind}.Sname='test6RblueXmed';
        ind=48; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6RblueXmed';
        ind=49; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6RblueXmed';
        % blue med light
        ind=50; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluemed';
        ind=51; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102121';mouse_info{ind}.Sname='test6Rbluemed';
        ind=52; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6Rbluemed';
        ind=53; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6Rbluemed';
        
        % blue low light
        ind=54; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluelow';
        ind=55; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='102121';mouse_info{ind}.Sname='test6Rbluelow';
        ind=56; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6Rbluelow';
        ind=57; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6Rbluelow';
    case 'opn4'
        
        my_path='D:\DATA_Glab\fiberphotometry\TDT_test6R_opn4_antagonist\';
        % without blue light
        states={'White light' , 'Opn4 ant. white',  'DMSO','Red light' , 'Opn4 ant. red' };
        intensities=[4.49e14, 4.49e14, 4.49e14, 1.95E14, 1.95E14];

        % with bluw elight
       % states={'White light' , 'Opn4 ant. white',  'DMSO','Red light' , 'Opn4 ant. red' ,'blue dim light' ,'blue bright light' , 'Opn4 ant. blue dim' 'Opn4 ant. blue bright', 'Opn4 ant. white','red dim light' ,'red bright light' };
        
        %b_states{1}='Before'; b_states{2}='After Opn4 antagonist'; b_states{3}='Before'; b_states{4}='After DMSO';
      %  styles={'k-', 'k--','k-.','k:' 'k-.','k:','k--','k:' 'k-.','k:', 'k--','k:' 'k-.'};
        styles2={'k-', 'k--','k-.','r:' 'r-.','b-','b--' 'b-.','b:', 'k--','r:' 'r-.'};
        g_colors={'k', 'b','g','r','y','r' 'b', 'b','b','b','b' 'b','b', 'b','k' 'k'};
       
        Groups={[1:9],[10:13],[14:17],[18:25],[26:28]}; % without blue light
       
              
        % full white light
        mouse_info{1}.ID='VIPGC262R';mouse_info{1}.side='R';mouse_info{1}.Gender='M'; mouse_info{1}.rig='TDT_test6R_red';;mouse_info{1}.date='020221';mouse_info{1}.Sname='test6R3';%
        mouse_info{2}.ID='VIPGC286R';mouse_info{2}.side='R';mouse_info{2}.Gender='M'; mouse_info{2}.rig='TDT_test6R_red';mouse_info{2}.date='071921';mouse_info{2}.Sname='test6R3';
         ind=3; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R3';
        ind=4; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R3';
         ind=5; mouse_info{ind}.ID='VIPGC246RL';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R3';
        ind=6; mouse_info{ind}.ID='VIPGC247RRL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R2';
        ind=7; mouse_info{ind}.ID='VIPGC259R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R1';
        ind=8; mouse_info{ind}.ID='VIPGC260L';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R1';
        ind=9; mouse_info{ind}.ID='VIPGC261RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6R1';
        

        % opn4 antagonist
        ind=10; mouse_info{ind}.ID='VIPGC262R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='020221';mouse_info{ind}.Sname='test6R4';%
        ind=11; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R4';
        ind=12; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R4';
        ind=13; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R4';
          
        % white light before DMSO
        % ind=9; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R5';
        % ind=10; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R5';
        % ind=11; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R5';
        % ind=12; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072721';mouse_info{ind}.Sname='test6R5';
        
        
        % DMSO only
        ind=14; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R6';
        ind=15; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R6';
        ind=16; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R6';
        ind=17; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072721';mouse_info{ind}.Sname='test6R6';
        
        % room Red light
        ind=18; mouse_info{ind}.ID='VIPGC246RL';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=19; mouse_info{ind}.ID='VIPGC247RRL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=20; mouse_info{ind}.ID='VIPGC259R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=21; mouse_info{ind}.ID='VIPGC260L';mouse_info{ind}.side='L';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';
        ind=22; mouse_info{ind}.ID='VIPGC261RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101420';mouse_info{ind}.Sname='test6Rred1';

        ind=23; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
        ind=24; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
        ind=25; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
        
        % Red light after opn4 antagonist
        ind=26; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R10';
        ind=27; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R10';
        ind=28; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R10';
        
            
end


