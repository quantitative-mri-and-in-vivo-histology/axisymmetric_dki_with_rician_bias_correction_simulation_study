function [ simulation_voxels_table, dataset_names] = simulation_load_paper_invivo_tensors(path_of_script)
%% White matter
load([path_of_script filesep 'Datasets' filesep 'In-Vivo' filesep 'invivo_datasets.mat']); 


simulation_voxels =[Dataset_cb, Dataset_ct, Dataset_or, Dataset_slf, Dataset_mc, Dataset_vc, Dataset_th, Dataset_fc];
% order of parameters here: D11, D22, D33, D12, D13, D23, S0, W1111,
% W2222, W3333, W1112, W1113, W2221, W3331, W2223, W3332, W1122, W1133,
% W2233, W1123, W2213, W3312

simulation_voxels (7,:) = 1;
    tensor_element_order = {'D11', 'D22', 'D33', ...
        'D12', 'D13', 'D23', ...
        'S0',  'W1111', 'W2222', ...
        'W3333', 'W1112', 'W1113', ...
        'W2221', 'W3331', 'W2223', ...
        'W3332', 'W1122', 'W1133', ...
        'W2233', 'W1123', 'W2213', ...
        'W3312'};


    dataset_names = {'cb_voxel_1', 'cb_voxel_2', 'cb_voxel_3', ...
        'ct_voxel_1', 'ct_voxel_2', 'ct_voxel_3', ...
        'or_voxel_1', 'or_voxel_2', 'or_voxel_3', ...
        'slf_voxel_1', 'slf_voxel_2', 'slf_voxel_3', ...
        'mc_voxel_1', 'mc_voxel_2', 'mc_voxel_3', ...
        'vc_voxel_1', 'vc_voxel_2', 'vc_voxel_3', ...
        'th_voxel_1', 'th_voxel_2', 'th_voxel_3', ...
        'fc_voxel_1', 'fc_voxel_2', 'fc_voxel_3', ...
        };


    simulation_voxels_table = array2table(simulation_voxels,'VariableNames',dataset_names,'RowNames', tensor_element_order);

end