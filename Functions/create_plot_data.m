function [bias_threshold, std_threshold, names] = create_plot_data(results,simulated_SNRs)

max_n = 200;
crit_val = 5; % threshold for difference to ground truth

inx_wm =[1:12];
inx_gm =[13:24];
inx_HA = 25;
inx_MA = 26;
Inx_La = 27;
bias_average = struct;
 names = {'wm','gm','HA','MA','LA'};

   for inx_names = 1:numel(names)
    for AxTM_index =1:5
      for index_SNR = 1:max_n
         
        if inx_names == 1
            which_voxels = [1:12];
        elseif inx_names == 2
            which_voxels = [13:24];
        elseif inx_names == 3
            which_voxels = 25;
        elseif inx_names == 4
            which_voxels = 26;
        elseif inx_names == 5
            which_voxels = 27;
        end
       
    
           bias_average.(names{inx_names})(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(which_voxels,AxTM_index,index_SNR));mean(results.bias_AxDKI(which_voxels,AxTM_index,index_SNR)); ...
                                                      mean(results.bias_standardDKI_RBC(which_voxels,AxTM_index,index_SNR)); mean(results.bias_AxDKI_RBC(which_voxels,AxTM_index,index_SNR))];
    
           std_average.(names{inx_names})(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(which_voxels,AxTM_index,index_SNR)); mean(results.std_AxDKI(which_voxels,AxTM_index,index_SNR)); ...
                                                      mean(results.std_standardDKI_RBC(which_voxels,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(which_voxels,AxTM_index,index_SNR))];
          
    
      end
    end
   end


  bias_threshold = struct;      
  std_threshold = struct;      
               
 for inx_names = 1:numel(names)


  bias_threshold.(names{inx_names}) = find_snr_threshold(bias_average.(names{inx_names}),crit_val,simulated_SNRs,max_n);
  bias_threshold.(names{inx_names})(6,:) = max(bias_threshold.(names{inx_names}),[],1,'includenan'); %maximum row


  std_threshold.(names{inx_names}) = find_snr_threshold(std_average.(names{inx_names}),crit_val,simulated_SNRs,max_n);
  std_threshold.(names{inx_names})(6,:) = max(std_threshold.(names{inx_names}),[],1,'includenan' ); %maximum row



 end















end