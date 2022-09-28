function [bias_threshold, std_threshold] = create_plot_data(results,simulated_SNRs)

max_n = 200;
crit_val = 5; % threshold for difference to ground truth


for AxTM_index =1:5
  for index_SNR = 1:max_n
     


       bias_average_wm(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(1:12,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(1:12,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(1:12,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(1:12,AxTM_index,index_SNR))];

       std_average_wm(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(1:12,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(1:12,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(1:12,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(1:12,AxTM_index,index_SNR))];



       bias_average_gm(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(13:24,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(13:24,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(13:24,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(13:24,AxTM_index,index_SNR))];

       std_average_gm(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(13:24,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(13:24,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(13:24,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(13:24,AxTM_index,index_SNR))];


       bias_average_HA(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(25,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(25,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(25,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(25,AxTM_index,index_SNR))];

       std_average_HA(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(25,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(25,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(25,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(25,AxTM_index,index_SNR))];

       bias_average_MA(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(26,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(26,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(26,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(26,AxTM_index,index_SNR))];

       std_average_MA(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(26,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(26,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(26,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(26,AxTM_index,index_SNR))];

       bias_average_LA(AxTM_index,index_SNR,:) = [mean(results.bias_standardDKI(27,AxTM_index,index_SNR)); mean(results.bias_standardDKI_RBC(27,AxTM_index,index_SNR)); ...
                                                 mean(results.bias_AxDKI(27,AxTM_index,index_SNR));mean(results.bias_AxDKI_RBC(27,AxTM_index,index_SNR))];

       std_average_LA(AxTM_index,index_SNR,:) = [mean(results.std_standardDKI(27,AxTM_index,index_SNR)); mean(results.std_standardDKI_RBC(27,AxTM_index,index_SNR)); ...
                                                 mean(results.std_AxDKI(27,AxTM_index,index_SNR));mean(results.std_AxDKI_RBC(27,AxTM_index,index_SNR))];
      

  end
end



  bias_threshold = struct;      
  std_threshold = struct;      
               
  bias_threshold.wm = find_snr_threshold(bias_average_wm,crit_val,simulated_SNRs,max_n);
  bias_threshold.gm = find_snr_threshold(bias_average_gm,crit_val,simulated_SNRs,max_n);
  bias_threshold.HA = find_snr_threshold(bias_average_HA,crit_val,simulated_SNRs,max_n);
  bias_threshold.MA = find_snr_threshold(bias_average_MA,crit_val,simulated_SNRs,max_n);
  bias_threshold.LA = find_snr_threshold(bias_average_LA,crit_val,simulated_SNRs,max_n);


               
  std_threshold.wm = find_snr_threshold(std_average_wm,crit_val,simulated_SNRs,max_n);
  std_threshold.gm = find_snr_threshold(std_average_gm,crit_val,simulated_SNRs,max_n);
  std_threshold.HA = find_snr_threshold(std_average_HA,crit_val,simulated_SNRs,max_n);
  std_threshold.MA = find_snr_threshold(std_average_MA,crit_val,simulated_SNRs,max_n);
  std_threshold.LA = find_snr_threshold(std_average_LA,crit_val,simulated_SNRs,max_n);
 













end