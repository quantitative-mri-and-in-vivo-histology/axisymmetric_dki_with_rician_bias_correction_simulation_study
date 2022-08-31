function [simulation_voxels_axDKI_table] = simulation_load_paper_synth_datasets()
    
    MA(1,1)=1.557; % Dpara   
    MA(2,1)=1.048; % Dperp
    MA(3,1)=0.396; % Wpara
    MA(4,1)=0.708; % Wperp
    MA(5,1)=0.330; % Wmean
    
    LA(1,1)=0.457;
    LA(2,1)=0.408;
    LA(3,1)=2.901;
    LA(4,1)=2.702; 
    LA(5,1)=2.770; 
    
    
    HA(1,1)=1.503;
    HA(2,1)=0.195;
    HA(3,1)=1.456;
    HA(4,1)=0.291;
    HA(5,1)=0.926;
    
    
    
             
    simulation_voxels =[HA, MA, LA];
    
    dataset_names ={'HA','MA','LA'};
    
    axDKI_parameter_order = {'Dpara','Dperp','Wpara','Wperp','Wmean'};

    simulation_voxels_axDKI_table=  array2table(simulation_voxels,'VariableNames',dataset_names,'RowNames', axDKI_parameter_order);


end