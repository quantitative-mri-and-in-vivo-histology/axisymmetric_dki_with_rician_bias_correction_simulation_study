function Evaluation_AxDKI_RBC_Paper

path_of_script = fileparts(mfilename('fullpath'));
addpath(genpath([path_of_script filesep 'Functions']));

number_of_noise_realizations = 2500;
L = 2; %number of coils
% simulated_SNRs = [1/sqrt(2):(1/sqrt(2)):200/sqrt(2)]; %SNR divided by sqrt(2), L=number of coils = 2
simulated_SNRs = [1:1:200];

simulate_data(path_of_script,number_of_noise_realizations,simulated_SNRs,L);

results = struct;


voxel_folder = {'cb_voxel_1', 'cb_voxel_2', 'cb_voxel_3', ...
'ct_voxel_1', 'ct_voxel_2', 'ct_voxel_3', ...
'or_voxel_1', 'or_voxel_2', 'or_voxel_3', ...
'slf_voxel_1', 'slf_voxel_2', 'slf_voxel_3', ...
'mc_voxel_1', 'mc_voxel_2', 'mc_voxel_3', ...
'vc_voxel_1', 'vc_voxel_2', 'vc_voxel_3', ...
'th_voxel_1', 'th_voxel_2', 'th_voxel_3', ...
'fc_voxel_1', 'fc_voxel_2', 'fc_voxel_3', ...
'HA', 'MA','LA'};
        



slice = 2;

create_directories_results(path_of_script, voxel_folder, simulated_SNRs)

fit_voxels(path_of_script,simulated_SNRs,voxel_folder,L)

results = read_fit_results_and_compute_a_mpe_and_a_std(path_of_script,voxel_folder,simulated_SNRs,number_of_noise_realizations,slice,results);

[bias_threshold, std_threshold] = create_plot_data(results,simulated_SNRs);





end
