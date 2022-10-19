function  create_csv_files(bias_threshold, std_threshold,AxTM,path_of_script,names)

    algo_names = {'standard DKI', 'AxDKI' , 'standard DKI RBC', 'AxDKI RBC'};
    
    for i = 1:5
     
        table = array2table(bias_threshold.(names{i})','RowNames',algo_names,'VariableNames',[AxTM,'Maximum']);
        table_name = [path_of_script filesep 'Results_And_Figures' filesep 'Figure_Data' filesep names{i} '_table.csv'];
        writetable(table,table_name)
% 
%         table_2 =  array2table(std_threshold.(names{i}),'VariableNames',algo_names,'RowNames',[AxTM,'Maximum']);
%         table_2_name = [path_of_script filesep 'Results_And_Figures' filesep 'Figure_Data' filesep names{i} '_std_table.csv'];
%         writetable(table_2,table_2_name)

    end
    
    
    
    


end