function [SNR_threshold] = find_snr_threshold(bias_average,crit_val,simulated_SNRs)

 for index_alogrithm = 1:4    
    for AxTM_index = 1:5

             if and (~isempty( max(find([bias_average(AxTM_index,:,index_alogrithm)] >= crit_val)) ), max(find([bias_average(AxTM_index,:,index_alogrithm)] >= crit_val)) ~= max_n)
        
                 index_crit_val(AxTM_index,index_alogrithm) = 1 + max(find([bias_average(AxTM_index,:,index_alogrithm)] >= crit_val));
                 SNR_threshold(AxTM_index,index_alogrithm) = {simulated_SNRs(index_crit_val(AxTM_index,index_alogrithm))};
    
             else
                 SNR_threshold(AxTM_index) = {NaN};
             end
    
    end
 end


end