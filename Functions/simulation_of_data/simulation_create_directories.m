function simulation_create_directories(outdir, simulation_name, voxel_positions, snrs)

  
folder_simulation_data = [outdir filesep 'simulation_data' ];

if ~exist(folder_simulation_data,'dir')
  status = mkdir(folder_simulation_data);
end
            
folder_simulation_name = [ folder_simulation_data filesep simulation_name ];

  
if ~exist(folder_simulation_name,'dir')
  status = mkdir(folder_simulation_name);
end
         

for inx_voxel = 1 : size(voxel_positions,2)
    voxel_name = voxel_positions{inx_voxel};
    folder_voxel_name = [folder_simulation_name filesep voxel_name];
    if ~exist(folder_voxel_name,'dir')
      status = mkdir(folder_voxel_name);
    end
        for inx_snr = 1 : size(snrs,2)
            folder_snr = [folder_voxel_name filesep 'simulated_SNR_' num2str(inx_snr)];
              if ~exist(folder_snr,'dir')
                status = mkdir(folder_snr);
              end
        end
end




