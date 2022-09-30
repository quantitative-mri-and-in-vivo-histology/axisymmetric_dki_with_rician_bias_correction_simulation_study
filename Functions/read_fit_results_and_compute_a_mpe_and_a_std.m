function  [results] = read_fit_results_and_compute_a_mpe_and_a_std(path_of_script,voxel_folder,simulated_SNRs,number_of_noise_realizations,slice,results,AxTM)






 perc = 5; %
 
 accuracy_threshold = 0.05; % threshold for ground truth reproduction (= 5% difference to ground truth)
 
 standardDKI_AxTMs = zeros(1, numel(AxTM));

load([path_of_script filesep 'Datasets' filesep 'GroundTruth' filesep 'GT_Table.mat'],'GT_Table')



  for inx_voxel = 1:size(voxel_folder,2)
  
      if inx_voxel <= 24
          folder_key = 'standard';
      elseif inx_voxel >= 25
          folder_key = 'axisymmetric';
      end

        for index_SNR = simulated_SNRs
    
            
              Vol = cell(1,numel(AxTM));
    
    
              for AxTM_index = 1:numel(AxTM)
                    um_conversion = 1;
                    if AxTM_index >= 4
                        um_conversion = 1000; % to convert the diffusivites from mm^2/s to um^2/ms
                    end

                  AxTM_map_name_1 = ['SNR_' num2str(index_SNR)  '_simulation_' folder_key '_DKI_001_desc-NLLS-AxDKI-' AxTM{AxTM_index} '_dwi.nii'];
                  AxTM_map_name_2 = ['SNR_' num2str(index_SNR)  '_simulation_' folder_key '_DKI_001_desc-DKI-NLLS-' AxTM{AxTM_index} '_dwi.nii'];
                  AxTM_map_name_3 = ['SNR_' num2str(index_SNR)  '_simulation_' folder_key '_DKI_001_desc-DKI-NLLS-RBC-' AxTM{AxTM_index} '_dwi.nii'];
                  AxTM_map_name_4 = ['SNR_' num2str(index_SNR)  '_simulation_' folder_key '_DKI_001_desc-NLLS-AxDKI-RBC-' AxTM{AxTM_index} '_dwi.nii'];

                  Vol{1,AxTM_index} = (spm_vol([path_of_script filesep 'Results_And_Figures' filesep 'Fit_Results' filesep 'voxels' filesep voxel_folder{inx_voxel} filesep  'simulated_SNR_' num2str(find(simulated_SNRs==index_SNR)) filesep 'AxDKI' filesep 'DKI-NLLS-Run' filesep AxTM_map_name_1]));  
                  Vol{2,AxTM_index} = (spm_vol([path_of_script filesep 'Results_And_Figures' filesep 'Fit_Results' filesep 'voxels' filesep voxel_folder{inx_voxel} filesep  'simulated_SNR_' num2str(find(simulated_SNRs==index_SNR)) filesep 'standardDKI' filesep 'DKI-NLLS-Run' filesep AxTM_map_name_2]));  
                  Vol{3,AxTM_index} = (spm_vol([path_of_script filesep 'Results_And_Figures' filesep 'Fit_Results' filesep 'voxels' filesep voxel_folder{inx_voxel} filesep  'simulated_SNR_' num2str(find(simulated_SNRs==index_SNR)) filesep 'standardDKI_RBC' filesep 'DKI-NLLS-Run' filesep AxTM_map_name_3]));  
                  Vol{4,AxTM_index} = (spm_vol([path_of_script filesep 'Results_And_Figures' filesep 'Fit_Results' filesep 'voxels' filesep voxel_folder{inx_voxel} filesep  'simulated_SNR_' num2str(find(simulated_SNRs==index_SNR)) filesep 'AxDKI_RBC' filesep 'DKI-NLLS-Run' filesep AxTM_map_name_4]));  
    
                 standardDKI_AxTMs_tmp = acid_read_vols(Vol{2,AxTM_index},Vol{1,1},-4).*um_conversion; 
                 standardDKI_RBC_AxTMs_tmp = acid_read_vols(Vol{3,AxTM_index},Vol{1,1},-4).*um_conversion; 
                 AxDKI_AxTMs_tmp = acid_read_vols(Vol{1,AxTM_index},Vol{1,1},-4).*um_conversion; 
                 AxDKI_RBC_AxTMs_tmp = acid_read_vols(Vol{4,AxTM_index},Vol{1,1},-4).*um_conversion; 



                 
                 standardDKI_AxTMs(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanmean(standardDKI_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all');
                 standardDKI_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanstd(standardDKI_AxTMs_tmp(2,1:number_of_noise_realizations,slice),0,'all');
%                  standardDKI_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = iqr(standardDKI_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all')/1.3490;
    
                 standardDKI_RBC_AxTMs(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanmean(standardDKI_RBC_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all');
                 standardDKI_RBC_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanstd(standardDKI_RBC_AxTMs_tmp(2,1:number_of_noise_realizations,slice),0,'all');
%                  standardDKI_RBC_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = iqr(standardDKI_RBC_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all')/1.3490;
    
                 AxDKI_AxTMs(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanmean(AxDKI_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all');
                 AxDKI_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanstd(AxDKI_AxTMs_tmp(2,1:number_of_noise_realizations,slice),0,'all');
%                  AxDKI_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = iqr(AxDKI_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all')/1.3490;
    
                 AxDKI_RBC_AxTMs(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanmean(AxDKI_RBC_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all');
                 AxDKI_RBC_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = nanstd(AxDKI_RBC_AxTMs_tmp(2,1:number_of_noise_realizations,slice),0,'all');
%                  AxDKI_RBC_AxTMs_STD(inx_voxel,AxTM_index,find(simulated_SNRs==index_SNR)) = iqr(AxDKI_RBC_AxTMs_tmp(2,1:number_of_noise_realizations,slice),'all')/1.3490;

                 
                 
                 
                 
              
              end
    
                 clear Vol
     
        
        end
  end
         



for inx_voxel = 1:size(voxel_folder,2)
    for AxTM_index = 1:numel(AxTM)

            Ground_Truth_Value =  GT_Table.(AxTM{AxTM_index})(voxel_folder{inx_voxel});    
                   
            results.bias_standardDKI(inx_voxel,AxTM_index,:) = 100*abs(Ground_Truth_Value - standardDKI_AxTMs(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
            results.bias_standardDKI_RBC(inx_voxel,AxTM_index,:) = 100*abs(Ground_Truth_Value - standardDKI_RBC_AxTMs(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
       
            results.bias_AxDKI_RBC(inx_voxel,AxTM_index,:) = 100*abs(Ground_Truth_Value - AxDKI_RBC_AxTMs(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
            results.bias_AxDKI(inx_voxel,AxTM_index,:) = 100*abs(Ground_Truth_Value -AxDKI_AxTMs(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
            
            results.std_standardDKI(inx_voxel,AxTM_index,:)  = 100*abs(standardDKI_AxTMs_STD(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
            results.std_standardDKI_RBC(inx_voxel,AxTM_index,:)  = 100*abs(standardDKI_RBC_AxTMs_STD(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
    
            results.std_AxDKI(inx_voxel,AxTM_index,:)  = 100*abs( AxDKI_AxTMs_STD(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
            results.std_AxDKI_RBC(inx_voxel,AxTM_index,:)  = 100*abs(AxDKI_RBC_AxTMs_STD(inx_voxel,AxTM_index,:))/Ground_Truth_Value;
    end    
end        





    
    
    

% AxTM = {'$W_{\perp}$','$W_{\parallel}$','$\overline{W}$','$D_{\perp}$','$D_{\parallel}$'};
% SNR = simulated_SNRs * sqrt(2);
    

    for inx = 1:numel(AxTM)
% 
%         inx_GT = find_inx_GT(inx);
% 
% 
%         Ground_Truth_Value = GT(inx_GT,Dataset);
% 
% 
%         set(0,'defaulttextinterpreter','latex')
%         set(0,'DefaultTextFontname', 'Helvetica')
%         set(0,'DefaultAxesFontName', 'Helvetica')
%         
%        
%     
%         display_name_1 = ['DKI full tensor, RBC OFF'];
%         display_name_2 = ['DKI full tensor, RBC ON'];
% 
%         display_name_3 = ['Axial Symmetric DKI, RBC OFF'];
%         display_name_4 = ['Axial Symmetric DKI, RBC ON'];
% 
% 
%         figure('DefaultAxesFontSize',13); 
%         hold on
%         set(0,'defaulttextinterpreter','latex')
%         set(0,'DefaultTextFontname', 'Helvetica')
%         set(0,'DefaultAxesFontName', 'Helvetica')
% %         errorbar(SNR((1:end)),standardDKI_AxTMs(:,inx),standardDKI_AxTMs_STD(:,inx)/sqrt(q1*q2),'Color',[0 0.600000023841858 1],'Marker','.','MarkerSize',13,'DisplayName', display_name_1);
% %         errorbar(SNR((1:end)),standardDKI_RBC_AxTMs(:,inx),standardDKI_RBC_AxTMs_STD(:,inx)/sqrt(q1*q2),'Color',[0.65 0.10 0.83],'Marker','.','MarkerSize',13,'DisplayName', display_name_2);
% %         errorbar(SNR((1:end)),AxDKI_AxTMs(:,inx),AxDKI_AxTMs_STD(:,inx)/sqrt(q1*q2),'Color',[0.03 0.90 1.00],'Marker','.','MarkerSize',13,'DisplayName', display_name_3);
% %         errorbar(SNR((1:end)),AxDKI_RBC_AxTMs(:,inx),AxDKI_RBC_AxTMs_STD(:,inx)/sqrt(q1*q2),'Color',[1.00 0.00 0.74],'Marker','.','MarkerSize',13,'DisplayName', display_name_4);
% 
%         plot(SNR((1:end)),100*abs(standardDKI_AxTMs_STD(:,inx))/Ground_Truth_Value,'Color',[0 0.600000023841858 1],'Marker','.','MarkerSize',13,'DisplayName', display_name_1);
%         plot(SNR((1:end)),100*abs(standardDKI_RBC_AxTMs_STD(:,inx))/Ground_Truth_Value,'Color',[0.65 0.10 0.83],'Marker','.','MarkerSize',13,'DisplayName', display_name_2);
%         plot(SNR((1:end)),100*abs( AxDKI_AxTMs_STD(:,inx))/Ground_Truth_Value,'Color',[0.03 0.90 1.00],'Marker','.','MarkerSize',13,'DisplayName', display_name_3);
%         plot(SNR((1:end)),100*abs(AxDKI_RBC_AxTMs_STD(:,inx))/Ground_Truth_Value,'Color',[1.00 0.00 0.74],'Marker','.','MarkerSize',13,'DisplayName', display_name_4);
% 
%         y3 = Ground_Truth_Value;
%         five_perc_GT=y3*perc/100;
%         y6_up=y3+five_perc_GT;
%         y6_down=y3-five_perc_GT;
%         line([SNR(1), SNR(end)],[y6_up,y6_up],'Color','red','DisplayName',['' num2str(perc) '% difference to Ground Truth'],'MarkerSize', 13)
%         line([SNR(1), SNR(end)],[y6_down,y6_down],'Color','red','MarkerSize', 13,'HandleVisibility','off')
%         line([SNR(1), SNR(end)],[y3,y3],'Color','k','DisplayName','Ground Truth','MarkerSize',13)
%         ht=title(['Parameter: ' AxTM{inx} ', ' num2str(q1*q2), ' Noise Samples, tissue: ' tissue_folder ', Dataset:' num2str(Dataset)],'Interpreter','latex','FontWeight','bold') ;
%         set(ht,'FontSize',19)
%         legend('Location','best')
%         set(gca,'units','centimeters')
%         pos = get(gca,'Position');
%         ti = get(gca,'TightInset');
%         set(gcf, 'PaperUnits','centimeters');
%         set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
%         set(gcf, 'PaperPositionMode', 'manual');
%         set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]); 
%         xlabel('SNR')
%         ylabel('Mean and Std of the Mean','Interpreter','latex','FontWeight','bold')
%         legend


%das hier drüber aktivieren um die die zugehörigen figures zu plotten

    end




            
            
            
            



      
    
end
















