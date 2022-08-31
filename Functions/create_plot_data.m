function create_plot_data(results,simulated_SNRs)

max_n = 200;
crit_val = 5; % threshold for difference to ground truth


for AxTM_index =1:5
  for index_SNR = inx
     


       bias_average_wm(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(1:12,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(1:12,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(1:12,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(1:12,AxTM_index,index_SNR))];

       std_average_wm(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(1:12,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(1:12,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(1:12,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(1:12,AxTM_index,index_SNR))];



       bias_average_gm(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(13:24,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(13:24,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(13:24,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(13:24,AxTM_index,index_SNR))];

       std_average_gm(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(13:24,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(13:24,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(13:24,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(13:24,AxTM_index,index_SNR))];

      

  end
end

            
               
  bias_threshold_wm = find_snr_threshold(bias_average_wm,crit_val,simulated_SNRs);
  bias_threshold_gm = find_snr_threshold(bias_average_gm,crit_val,simulated_SNRs);

               
  std_threshold_wm = find_snr_threshold(std_average_wm,crit_val,simulated_SNRs);
  std_threshold_gm = find_snr_threshold(std_average_gm,crit_val,simulated_SNRs);
 













end