function create_directories_results(path_of_script, voxel_positions, snrs)



for inx_voxel = 1 : size(voxel_positions,2)
    voxel_name = voxel_positions{inx_voxel};
    folder_voxel_name = [path_of_script filesep 'Results_And_Figures' filesep 'Fit_Results' filesep 'voxels' filesep voxel_name];
    if ~exist(folder_voxel_name,'dir')
      status = mkdir(folder_voxel_name);
    end
        for inx_snr = 1 : size(snrs,2)
            folder_snr = [folder_voxel_name filesep 'simulated_SNR_' num2str(inx_snr)];
            folder_1 = [folder_snr filesep 'AxDKI'];
            folder_2 = [folder_snr filesep 'AxDKI_RBC'];
            folder_3 = [folder_snr filesep 'standardDKI'];
            folder_4 = [folder_snr filesep 'standardDKI_RBC'];

              if ~exist(folder_snr,'dir')
                status = mkdir(folder_snr);
              end
              
             if ~exist(folder_1,'dir')
                status = mkdir(folder_1);
              end

           if ~exist(folder_2,'dir')
            status = mkdir(folder_2);
           end

           if ~exist(folder_3,'dir')
            status = mkdir(folder_3);
           end


           if ~exist(folder_4,'dir')
            status = mkdir(folder_4);
           end

        end
end




