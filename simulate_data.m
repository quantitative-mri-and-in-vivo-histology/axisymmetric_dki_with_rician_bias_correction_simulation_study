function  simulate_data(path_of_script,number_of_noise_realizations,simulated_SNRs,L)

        
    simulation_parameters.outdir  =  {[path_of_script]};
    
    [simulation_voxels_table, dataset_names] = simulation_load_paper_invivo_tensors(path_of_script);
    
    [simulation_voxels_axDKI_table] = simulation_load_paper_synth_datasets();
    
    load([path_of_script filesep 'Datasets' filesep 'bvalues_and_bvectors' filesep 'bvec_simulation_AxDKI_RBC.mat']);
    load([path_of_script filesep 'Datasets' filesep 'bvalues_and_bvectors' filesep 'bval_simulation_AxDKI_RBC.mat']);
    
    simulation_parameters.simulation_bvals = bval_simulation;
    simulation_parameters.simulation_bvecs = bvec_simulation;
    
    simulation_parameters.simulation_name = 'simulation_of_paper_data';
    simulation_parameters.n_noise_samples = number_of_noise_realizations;
    simulation_parameters.simulation_snrs = simulated_SNRs;
    simulation_parameters.L               = L;

    
    
    for inx = 1: size(dataset_names,2)
        voxel_positions_invivo{:,inx} =dataset_names{inx};
    end
    
    voxel_positions_synth = { 'HA', 'MA', 'LA' };
    
    
    simulation_create_directories(char(simulation_parameters.outdir), char(simulation_parameters.simulation_name), voxel_positions_invivo, simulation_parameters.simulation_snrs)
    simulation_create_directories(char(simulation_parameters.outdir), char(simulation_parameters.simulation_name), voxel_positions_synth, simulation_parameters.simulation_snrs)
    
    
    
    simulation_simulate_signals_based_on_standardDKI(path_of_script, simulation_voxels_table, simulation_parameters)
    
    simulation_simulate_signals_based_on_axDKI(path_of_script, simulation_voxels_axDKI_table,  simulation_parameters)
    
end




