function  remove_previous_result(path_of_script,inx_voxel,voxel_folder,index_snr,simulated_SNRs)

    directory =  [path_of_script filesep 'simulation_data' filesep 'simulation_of_paper_data' filesep voxel_folder{inx_voxel} filesep 'simulated_SNR_' num2str(find(simulated_SNRs==index_snr)) filesep];

    try
        rmdir([directory 'deriva*'],"s")
    catch
      
    end
 
end