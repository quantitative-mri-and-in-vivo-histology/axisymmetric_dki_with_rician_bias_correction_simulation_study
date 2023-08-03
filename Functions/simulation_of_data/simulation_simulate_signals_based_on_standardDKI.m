function simulation_simulate_signals_based_on_standardDKI(path_of_script, simulation_voxels_table,  simulation_parameters)

 
    
        
        contaminate_signal = simulation_parameters.contaminate_signal;
        
        
        bvalues = simulation_parameters.simulation_bvals/1000;
        diffusion_gradients = simulation_parameters.simulation_bvecs;
        [design_matrix_kurtosis] = simulation_design_matrix_standardDKI(diffusion_gradients,bvalues(1,:));

        
        
         
        
        
        simulated_SNRs = simulation_parameters.simulation_snrs;
        
        
        
         number_of_noise_realizations = simulation_parameters.n_noise_samples;
         

     

       
        for inx_voxel = 1: size(simulation_voxels_table,2)
               
          parameters = table2array(simulation_voxels_table(:,inx_voxel));

            for inx_snr = simulated_SNRs
             
        
                for m=1:number_of_noise_realizations
            
            
            
            
                         traceterm = ((parameters(1)+parameters(2)+parameters(3))/3).^2; %for the trace term in the DKI signal equation
                
                         signal = exp(design_matrix_kurtosis(:,1:6) * parameters(1:6) +  traceterm.* (design_matrix_kurtosis(:,8:22) * parameters(8:22) ) ) .* parameters(7) ; %Standard DKI signal 
                
                     
            
                          if (contaminate_signal == 1)
            
                                 for i = 1: size(signal,1)
    
                                  sigma = ( (1/(inx_snr)) * sqrt(2) ) ;     %SNR = sqrt(2) * S0/sigma          
                                  real =  random ( 'Normal', 0 , sigma );  
                                  imaginary =  random ( 'Normal', 0 , sigma );
                                  contaminated_signal = abs( ( signal(i) ) + complex ( real , imaginary ) ) ;
            
                                  signal(i) = contaminated_signal;
            
                                 end
                          end
            
            
                        simulated_signals(:,m) = signal*1000; % The image intensities should be between 0 and 1000 for ACID          
            
                end
        
        
        
      
        
        
           
            template = [path_of_script filesep 'template_simulation.nii'];
        
            volume = spm_vol(template);
            
            volume.dim = [2 number_of_noise_realizations 2];
                                    
            name_fix = '_standard_DKI';

            fname =['SNR_' num2str(inx_snr) '_simulation' name_fix];
                
            pth = [simulation_parameters.outdir{1} filesep 'simulation_data' filesep simulation_parameters.simulation_name filesep  simulation_voxels_table.Properties.VariableNames{inx_voxel} filesep 'simulated_SNR_' num2str(find(inx_snr == simulated_SNRs)) ];

            volume.fname =  [pth filesep fname '.mat']  ;



        
            A = zeros ( [ volume.dim , size(bvalues,2) ] ) ;
        
            k= 1;
            
            for slice = 2
                for i= 2 
                 for j=1:number_of_noise_realizations
        
                     temporary_signal = reshape (simulated_signals(:,k) , [1,1,numel(bvalues)] );
        
                     A( i , j, slice, 1:numel(bvalues)) =  temporary_signal ;
                     k=k+1;
        
                 end
                end
            end
        
                for inx=1:numel(bvalues)
        
                    if(inx<10)
                        num = ['_00' num2str(inx)];
                    elseif(inx<100)
                        num = ['_0' num2str(inx)];
                    elseif(inx<1000)
                        num = ['_' num2str(inx)];
                    end
        
        
                 my_write_vol_nii( A(:,:,:,inx) ,volume,'' ,num) ;
        
                end
        
        
            end
        
        end


end