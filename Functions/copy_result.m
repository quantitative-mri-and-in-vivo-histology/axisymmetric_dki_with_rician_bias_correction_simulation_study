function  copy_result(path_of_script,fit_methods,inx_voxel,voxel_folder,index_snr,simulated_SNRs)

    folder_1 = 'AxDKI';
    folder_2 = 'standardDKI';
    folder_3 = 'standardDKI_RBC';
    folder_4 = 'AxDKI_RBC';

    directory_destination =  [path_of_script filesep 'Results_And_Figures' filesep 'Fit_Results' filesep 'voxels' filesep voxel_folder{inx_voxel} filesep  'simulated_SNR_' num2str(find(simulated_SNRs==index_snr))];
    directory_source      =  [path_of_script filesep 'simulation_data' filesep 'simulation_of_paper_data' filesep voxel_folder{inx_voxel} filesep 'simulated_SNR_' num2str(find(simulated_SNRs==index_snr))];

    if fit_methods == 1
             destination = [directory_destination filesep folder_1];
             copyfile([directory_source filesep 'derivatives'], destination);
    elseif fit_methods == 2
             destination = [directory_destination filesep folder_2];
             copyfile([directory_source filesep 'derivatives'], destination);

    elseif fit_methods == 3
             destination = [directory_destination filesep folder_3];
             copyfile([directory_source filesep 'derivatives'], destination);

    elseif fit_methods == 4
             destination = [directory_destination filesep folder_4];
             copyfile([directory_source filesep 'derivatives'], destination);
    end

end