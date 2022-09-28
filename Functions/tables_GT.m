clear

    voxel_folder = {'cb_voxel_1', 'cb_voxel_2', 'cb_voxel_3', ...
'ct_voxel_1', 'ct_voxel_2', 'ct_voxel_3', ...
'or_voxel_1', 'or_voxel_2', 'or_voxel_3', ...
'slf_voxel_1', 'slf_voxel_2', 'slf_voxel_3', ...
'mc_voxel_1', 'mc_voxel_2', 'mc_voxel_3', ...
'vc_voxel_1', 'vc_voxel_2', 'vc_voxel_3', ...
'th_voxel_1', 'th_voxel_2', 'th_voxel_3', ...
'fc_voxel_1', 'fc_voxel_2', 'fc_voxel_3', ...
'HA', 'MA','LA'};
  

    load('GT_slf.mat')
    load('GT_cb.mat')
    load('GT_ct.mat')
    load('GT_or.mat')
    
    
    GT_slf(1:2,1:3) = GT_slf(1:2,1:3)*1000;
    GT_cb(1:2,1:3) = GT_cb(1:2,1:3)*1000;
    GT_or(1:2,1:3) = GT_or(1:2,1:3)*1000;
    GT_ct(1:2,1:3) = GT_ct(1:2,1:3)*1000;
    
    
for i = 1:3
  for j=1:5
     wm_gt{i,j}   = GT_cb(j,i);
     wm_gt{i+3,j} = GT_ct(j,i);
     wm_gt{i+6,j} = GT_or(j,i);
     wm_gt{i+9,j} = GT_slf(j,i);
     
    
  end  
end


            

    load('GT_fc.mat')
    load('GT_mc.mat')
    load('GT_th.mat')
    load('GT_vc.mat')    



    GT_vc(1:2,1:3) = GT_vc(1:2,1:3)*1000;
    GT_mc(1:2,1:3) = GT_mc(1:2,1:3)*1000;
    GT_th(1:2,1:3) = GT_th(1:2,1:3)*1000;
    GT_fc(1:2,1:3) = GT_fc(1:2,1:3)*1000;
    
    
for i = 1:3
  for j=1:5
     gm_gt{i,j}   = GT_mc(j,i);
     gm_gt{i+3,j} = GT_vc(j,i);
     gm_gt{i+6,j} = GT_th(j,i);
     gm_gt{i+9,j} = GT_fc(j,i);
     
    
  end  
end



%% HA
         AD={1.503};
         RD={0.195};
         AW={1.456};
         RW={0.291};
         MW={0.926};

         HA = [RD;AD;RW;AW;MW]';


 %% MA
         AD={1.557};
         RD={1.048};
         AW={0.396};
         RW={0.708};
         MW={0.330};
         
         MA = [RD;AD;RW;AW;MW]';

 %%LA


         AD={0.457};
         RD={0.408};
         AW={2.901};
         RW={2.702}; 
         MW={2.770};    
         
         LA =  [RD;AD;RW;AW;MW]';

table = [wm_gt;gm_gt;HA;MA;LA];

GT_Table = cell2table(table,'VariableNames',{'RD','AD','RW','AW','MW'},'RowNames',{voxel_folder{1,:}});





    