function simulation_simulate_signals_based_on_axDKI(path_of_script, simulation_voxels_axDKI_table,  simulation_parameters)

 
    
        
        contaminate_signal = simulation_parameters.contaminate_signal;
        
        
        bvalues = simulation_parameters.simulation_bvals/1000;
        diffusion_gradients = simulation_parameters.simulation_bvecs;

        
        u(1) = simulation_parameters.axis_of_symmetry(1); % the u1,u2 and u3 here are the components of the axis of symmetry
        u(2) = simulation_parameters.axis_of_symmetry(2);
        u(3) = simulation_parameters.axis_of_symmetry(3);        
         
        
        
        simulated_SNRs = simulation_parameters.simulation_snrs;
        
        
        
         number_of_noise_realizations = simulation_parameters.n_noise_samples;
         

     

       
        for inx_voxel = 1: size(simulation_voxels_axDKI_table,2)

             parameters = table2array(simulation_voxels_axDKI_table(:,inx_voxel));
                
             Dpara=parameters(1);
             Dperp=parameters(2);
             Wpara=parameters(3);
             Wperp=parameters(4);
             Wmean=parameters(5);   

            for inx_snr = simulated_SNRs
             
                        for m=1:number_of_noise_realizations
                        
                        
                        
                                    for i=1:3
                                        for j=1:3
                                            for k=1:3
                                                for l=1:3
                        
                                                 P(i,j,k,l) = u(i)*u(j)*u(k)*u(l);  
                        
                                                 Q(i,j,k,l) = (1/6) * ( u(i) * u(j) * kronDel(k,l) + u(i) * u(k) * kronDel(j,l) + u(i) * u(l) *kronDel(j,k) + u(j) * u(k) * kronDel(i,l) + u(j) * u(l) * kronDel(i,k) + u(k) * u(l) * kronDel(i,j) );
                        
                                                 II(i,j,k,l) =   (1/3) * ( kronDel(i,j) * kronDel(k,l) + kronDel(i,k) * kronDel(j,l) + kronDel(i,l) * kronDel(j,k) ) ;
                        
                                                 W(i,j,k,l) = (1/2) * ( 10 * Wperp + 5 * Wpara -15 * Wmean ) * P(i,j,k,l) + Wperp * II(i,j,k,l) + (3/2) * ( 5 * Wmean - Wpara - 4 * Wperp ) * Q(i,j,k,l);  
                        
                                                 D = Dperp * eye(3,3) + ( Dpara - Dperp ) * u' * u;
                        
                                                end
                                            end
                                        end
                                    end
                        
                                    for nmeas = 1: numel(bvalues) 
                        
                                        for i=1:3
                                            for j=1:3
                        
                                                exponent_D(nmeas,i,j) =    - bvalues(nmeas) * diffusion_gradients(i,nmeas) * diffusion_gradients(j,nmeas) * D(i,j) ;
                        
                                                for k=1:3
                                                    for l=1:3
                        
                        
                        
                        
                                                        exponent_W(nmeas,i,j,k,l) =  (1/6) * bvalues(nmeas)^2 * ( (1/3) * (2 * Dperp + Dpara) ) ^2 * W(i,j,k,l) * diffusion_gradients(i,nmeas) * diffusion_gradients(j,nmeas)* diffusion_gradients(k,nmeas) * diffusion_gradients(l,nmeas) ;  
                        
                        
                                                    end
                                                end
                                            end
                                        end
                                    end
                        
                                        summe_exponent = sum(reshape(exponent_D,numel(bvalues),[]),2) + sum(reshape(exponent_W,numel(bvalues),[]),2);
                                
                                
                                
                                        signal=exp(summe_exponent); 
                        
                        
                        
                        
                        
                        
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
                                    
            name_fix = '_axisymmetric_DKI';

            fname =['SNR_' num2str(inx_snr) '_simulation' name_fix];
        
            pth = [simulation_parameters.outdir{1} filesep 'simulation_data' filesep simulation_parameters.simulation_name filesep  simulation_voxels_axDKI_table.Properties.VariableNames{inx_voxel} filesep 'simulated_SNR_' num2str(find(inx_snr == simulated_SNRs)) ];

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