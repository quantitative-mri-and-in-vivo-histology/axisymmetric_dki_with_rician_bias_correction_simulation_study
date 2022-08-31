function  fit_voxels(path_of_script,simulated_SNRs,voxel_folder,L)



load([path_of_script filesep 'Datasets' filesep 'bvalues_and_bvectors' filesep 'bvec_simulation_AxDKI_RBC.mat']);
load([path_of_script filesep 'Datasets' filesep 'bvalues_and_bvectors' filesep 'bval_simulation_AxDKI_RBC.mat']);  
        
bvalues = bval_simulation/1000;
diffusion_gradients = bvec_simulation;



for inx_voxel = 1:size(voxel_folder,2)

  for fit_methods = 1:4

       if fit_methods == 1
           jobfile = {[path_of_script filesep 'SPM_Batches' filesep 'AxisymmetricDKI_job.m']};
       elseif fit_methods == 2
           jobfile = {[path_of_script filesep 'SPM_Batches' filesep 'StandardDKI_job.m']};
       elseif fit_methods == 3
            jobfile = {[path_of_script filesep 'SPM_Batches' filesep 'StandardDKI_RBC_job.m']};
       elseif fit_methods == 4
           jobfile = {[path_of_script filesep 'SPM_Batches' filesep 'AxisymmetricDKI_RBC_job.m']};
       end



    jobs = repmat(jobfile, 1, 1);


    for index_snr=simulated_SNRs
        PP=[];

        remove_previous_result(path_of_script,inx_voxel,voxel_folder,index_snr,simulated_SNRs)

         for inx_bvalues=1:151

            if(inx_bvalues<10)
                num = ['_00' num2str(inx_bvalues)];
            elseif(inx_bvalues<100)
                num = ['_0' num2str(inx_bvalues)];
            elseif(inx_bvalues<1000)
                num = ['_' num2str(inx_bvalues)];
            end

      
            if inx_voxel <= 24
                Ptmp=(spm_select('FPList', [path_of_script filesep 'simulation_data' filesep 'simulation_of_paper_data' filesep voxel_folder{inx_voxel} filesep 'simulated_SNR_' num2str(find(simulated_SNRs==index_snr)) filesep] , ...
                    ['^SNR_' num2str(index_snr) '_simulation_standard_DKI' num '.nii']));     
            elseif  inx_voxel > 24                           
                Ptmp=(spm_select('FPList', [path_of_script filesep 'simulation_data' filesep 'simulation_of_paper_data' filesep voxel_folder{inx_voxel} filesep 'simulated_SNR_' num2str(find(simulated_SNRs==index_snr)) filesep], ...
                    ['^SNR_' num2str(index_snr) '_simulation_axisymmetric_DKI' num '.nii'])); 
            end

            PP = cat(1,PP,Ptmp);
            clear Ptmp
         end

            images_to_be_fitted=cell(size(PP,1),1); 
            for inx=1:size(PP,1)
                images_to_be_fitted(inx) = {deblank(PP(inx,:))};
            end
            if fit_methods == 1 || fit_methods == 2
                inputs = cell(3, 1);
            elseif fit_methods == 3 || fit_methods == 4
                 inputs = cell(4, 1);
            end


        inputs{1, 1} = images_to_be_fitted; % Fit Diffusion Tensor: DTI images - cfg_files
        inputs{2, 1} = bvalues*1000; % Fit Diffusion Tensor: Diffusion directions (bvec) - cfg_entry
        inputs{3, 1} = diffusion_gradients; % Fit Diffusion Tensor: b-values (bval) - cfg_entry
        if fit_methods == 3 || fit_methods == 4
         inputs{4, 1} = (1000/index_snr)*sqrt(L);% here I have to put in the standard deviation which sigma = sqrt(2) * S0/SNR, for L=2 % Fit Diffusion Tensor: Standard deviation for Rician bias correction - cfg_entry
        end
    spm('defaults', 'FMRI');
    spm_jobman('run', jobs, inputs{:});

    copy_result(path_of_script,fit_methods,inx_voxel,voxel_folder,index_snr,simulated_SNRs)

    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




  end 
    
    
            
end

     



end

