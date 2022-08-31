path_of_script = fileparts(mfilename('fullpath'));


load('invivo_datasets.mat')



dataset_names = {'cb', 'ct','or', 'slf'};

for inx_dataset = 1: numel (dataset_names)
    for inx = 1:3

       if inx_dataset == 1 
           Dataset = Dataset_cb;
       elseif inx_dataset == 2
           Dataset = Dataset_ct;
       elseif inx_dataset == 3
           Dataset = Dataset_or;
       elseif inx_dataset == 4
           Dataset = Dataset_slf;
       end
    
        matrix(1,1) = Dataset(1,inx);
    
        matrix(2,2) = Dataset(2,inx);
    
        matrix(3,3) = Dataset(3,inx);
    
        matrix(1,2) = Dataset(4,inx);
        matrix(2,1) = Dataset(4,inx);
    
        matrix(1,3) = Dataset(5,inx);
        matrix(3,1) = Dataset(5,inx);
    
        matrix(2,3) = Dataset(6,inx);
        matrix(3,2) = Dataset(6,inx);
    
        [V,D] = eig(matrix);
    
        lambda1 = D(3,3);
        lambda2 = D(2,2);
        lambda3 = D(1,1);
    
        MD = trace(D)/3;
    
        deviation(inx_dataset, inx) = (abs(lambda2 - lambda3))/MD;
        clear matrix
    end

end
deviation = round(deviation,3);

deviation_table = array2table(deviation','VariableNames',dataset_names,'RowNames',{'Dataset 1', 'Datset 2', 'Dataset 3'});

%table2latex(deviation_table)