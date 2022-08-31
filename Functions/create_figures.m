function create_figures(Bias_values_full_no_rice,  Bias_values_full_rice  , Bias_values_ax_sym_rice  ,Bias_values_ax_sym_no_rice,Bias_values_full_no_rice_synth,  Bias_values_full_rice_synth  , Bias_values_ax_sym_rice_synth  ,Bias_values_ax_sym_no_rice_synth,Bias_values_full_no_rice_std_synth, Bias_values_full_rice_std_synth, Bias_values_ax_sym_no_rice_std_synth, Bias_values_ax_sym_rice_std_synth,Bias_values_full_no_rice_std,Bias_values_full_rice_std,Bias_values_ax_sym_no_rice_std,Bias_values_ax_sym_rice_std, AxTM, dummy_gm)

a=5;
b=4;
c=2;
d=1;
e=3;

crit_val = 5; % kritischer Wert ab dem die Mittelwerte die GT als gut geschätzt ansehen 0.05 = 5% Differenz zur GT

max_n =200;
range = [1/sqrt(2):(1/sqrt(2)):max_n/sqrt(2)]; %range defines the SNRs for simulation_Date = 1
SNR = sqrt(2) * range;
X1 = SNR;

Dataset1 = Bias_values_full_no_rice; %Bias_values_full_DKI_no_rice
Dataset2 = Bias_values_full_rice; %Bias_values_full_DKI_rice
Dataset3 = Bias_values_ax_sym_rice; %Bias_values_ax_sym_DKI_rice
Dataset4 = Bias_values_ax_sym_no_rice; %Bias_values_ax_sym_DKI_no_rice



Dataset5 = Bias_values_full_no_rice_std;
Dataset6 = Bias_values_full_rice_std;
Dataset7 = Bias_values_ax_sym_rice_std;
Dataset8 = Bias_values_ax_sym_no_rice_std;




            for which_parameter =1:5
              for which_SNR = 1:max_n
                 


                   Bias_Werte_Plot(which_parameter,which_SNR,:) = [mean(mean(squeeze((Dataset1(1:4,1:3,which_parameter,which_SNR))))); mean(mean(squeeze((Dataset2(1:4,1:3,which_parameter,which_SNR)))));mean(mean(squeeze((Dataset4(1:4,1:3,which_parameter,which_SNR)))));mean(mean(squeeze((Dataset3(1:4,1:3,which_parameter,which_SNR)))))];
                   Std_Werte_Plot(which_parameter,which_SNR,:) = [std(reshape(squeeze(Dataset1(1:4,1:3,which_parameter,which_SNR)),12,1)); std(reshape(squeeze(Dataset2(1:4,1:3,which_parameter,which_SNR)),12,1));std(reshape(squeeze(Dataset4(1:4,1:3,which_parameter,which_SNR)),12,1));std(reshape(squeeze(Dataset3(1:4,1:3,which_parameter,which_SNR)),12,1))];
                  
                   StandardDeviation_Precision(which_parameter,which_SNR,:) = [mean(mean(squeeze((Dataset5(1:4,1:3,which_parameter,which_SNR))))); mean(mean(squeeze((Dataset6(1:4,1:3,which_parameter,which_SNR)))));mean(mean(squeeze((Dataset8(1:4,1:3,which_parameter,which_SNR)))));mean(mean(squeeze((Dataset7(1:4,1:3,which_parameter,which_SNR)))))];


                end
            
            end


  [bar_plots_in_vivo,std_bar_plots_in_vivo] = determine_threshold_invivo(SNR,AxTM,crit_val,max_n,Bias_Werte_Plot,Std_Werte_Plot);

  [bar_plots_in_vivo_PRECISION] = determine_threshold_1Dataset(SNR,AxTM,crit_val,max_n,StandardDeviation_Precision);

  [bar_plots_HF, bar_plots_MF, bar_plots_DF, bar_plots_HF_PRECISION, bar_plots_MF_PRECISION, bar_plots_DF_PRECISION] = determine_threshold_synth(SNR,AxTM,crit_val,max_n, Bias_values_full_no_rice_std_synth, Bias_values_full_rice_std_synth, Bias_values_ax_sym_no_rice_std_synth, Bias_values_ax_sym_rice_std_synth, Bias_values_ax_sym_rice_synth, Bias_values_ax_sym_no_rice_synth, Bias_values_full_rice_synth, Bias_values_full_no_rice_synth);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DKI_parameters = {'$W_{\perp}$','$W_{\parallel}$','$\overline{W}$','$D_{\perp}$','$D_{\parallel}$'};
parameter_names =  categorical({DKI_parameters{a},DKI_parameters{b},DKI_parameters{c},DKI_parameters{d}, DKI_parameters{e}, 'Worst'});

for method = 1:2 %5% threshold or precision
         position = [ 335         236        1077         630];
        
        f = figure;
        f.Position = position;
        
        for inx_worst = 1:4
            if method == 1
                bar_plots_HF(6,inx_worst) = max(bar_plots_HF(:,inx_worst));
                bar_plots_DF(6,inx_worst) = max(bar_plots_DF(:,inx_worst));
                bar_plots_MF(6,inx_worst) = max(bar_plots_MF(:,inx_worst));
                bar_plots_in_vivo(6,inx_worst) = max(bar_plots_in_vivo(:,inx_worst));
            elseif method == 2
                bar_plots_HF_PRECISION(6,inx_worst) = max(bar_plots_HF_PRECISION(:,inx_worst));
                bar_plots_DF_PRECISION(6,inx_worst) = max(bar_plots_DF_PRECISION(:,inx_worst));
                bar_plots_MF_PRECISION(6,inx_worst) = max(bar_plots_MF_PRECISION(:,inx_worst));
                bar_plots_in_vivo_PRECISION(6,inx_worst) = max(bar_plots_in_vivo_PRECISION(:,inx_worst)); 
            end
        end
        
      if method == 1  
        Data(:,:,1) = bar_plots_HF;
        Data(:,:,2) = bar_plots_MF;
        Data(:,:,3) = bar_plots_DF;
        Data(:,:,4) = bar_plots_in_vivo;
      elseif method == 2
        Data(:,:,1) = bar_plots_HF_PRECISION;
        Data(:,:,2) = bar_plots_MF_PRECISION;
        Data(:,:,3) = bar_plots_DF_PRECISION;
        Data(:,:,4) = bar_plots_in_vivo_PRECISION;     
      end

        %Data 1: Parameters and Worst SNR across all five
        %Data 2: Algorithm
        %Data 3: HF; MF; DF; In-Vivo
        kk = 1; %Laufvariable

% 
%     for inx_dataset= 1:4
%         for inx_parameter = 1:6
%         
% 
% 
% 
% 
%         
%                         s= subplot(4,6,kk);   
%         
%         %                 X = categorical({DKI_parameters{1},DKI_parameters{2},DKI_parameters{3},DKI_parameters{4}, DKI_parameters{5}});
%                         name =parameter_names(inx_parameter);
%                        
%                         b = bar(1,Data(inx_parameter,:,inx_dataset));
%                         set(b(2),'FaceColor',[0.03 0.9 1],'DisplayName','Axisymmetric DKI RBC OFF');
%                         set(b(4),'FaceColor',[1 0 0.74],'DisplayName','Axisymmetric DKI RBC ON');
%                         set(b(1),'FaceColor',[0 0.600000023841858 1],'DisplayName','Standard DKI RBC OFF');
%                         set(b(3),'FaceColor',[0.65 0.1 0.83],'DisplayName','Standard DKI RBC ON');
%     
%                         
%                         if inx_dataset == 4 && inx_parameter <6 && method == 1
%                                              hold on
%                                         % Calculate the number of groups and number of bars in each group
%                                         [ngroups,nbars] = size(Data(inx_parameter,:,inx_dataset));
%                                         % Get the x coordinate of the bars
%                                         x = nan(nbars, ngroups);
%                                         for i = 1:nbars
%                                             x(i,:) = b(i).XEndPoints;
%                                         end
%                                         % Plot the errorbars
%                                         errorbar(x',Data(inx_parameter,:,inx_dataset),std_bar_plots_in_vivo(inx_parameter,:),'k','linestyle','none','HandleVisibility','off','LineWidth',1.5,'Marker','.','MarkerSize',12);
%                                         hold off
%                         
%                         end
%     
%     
%     
%                         
%                         if inx_dataset == 1
%                            title(name,'interpreter','latex')
%                         end
%                         set(s, 'XTick',1,'XTickLabel','');
%                      if inx_dataset == 1 && inx_parameter == 1
%     
%                         ylabel('HA');
%                       hYLabel = get(gca,'YLabel');
%                       set(hYLabel,'rotation',0,'VerticalAlignment','middle') 
%     
%     
%                      elseif inx_dataset == 2 && inx_parameter == 1
%     
%                         ylabel('MA');
%                       hYLabel = get(gca,'YLabel');
%                       set(hYLabel,'rotation',0,'VerticalAlignment','middle')    
%     
%                      elseif inx_dataset == 3 && inx_parameter == 1
%     
%                         ylabel('LA');
%                       hYLabel = get(gca,'YLabel');
%                       set(hYLabel,'rotation',0,'VerticalAlignment','middle')
%     
%     
%                      elseif inx_dataset == 4 && inx_parameter == 1
%     
%                         ylabel('In-vivo');
%                       hYLabel = get(gca,'YLabel');
%                       set(hYLabel,'rotation',0,'VerticalAlignment','middle')    
%     
%                      end
%     
%                         set(s, 'YTick',1,'YTickLabel','');
%     
%                         
%                         xtips1 = b(1).XEndPoints;
%                         ytips1 = b(1).YEndPoints;
%     
%                         
%                         labels1 = string(b(1).YData);
%     
%               
%     
%                         
%                         xtips2 = b(2).XEndPoints;
%                         ytips2 = b(2).YEndPoints;
%                         labels2 = string(b(2).YData);
%     
%     
%     
%                                      
%                         xtips3 = b(3).XEndPoints;
%                         ytips3 = b(3).YEndPoints;
%                         labels3 = string(b(3).YData);
%            
%                       
%                         
%                                                      
%                         xtips4 = b(4).XEndPoints;
%                         ytips4 = b(4).YEndPoints;
%                         labels4 = string(b(4).YData);
%     
% %         
% %     
% %                         if inx_dataset == 2 && inx_parameter == 3
% %                             labels2 = '>100';
% %                             labels1 = '>100'; 
% %     
% %                         elseif inx_dataset == 2 && inx_parameter == 5
% %                             labels2 = '>100';
% %                             labels1 = '>100'; 
% %     
% %                         elseif inx_dataset == 2 && inx_parameter == 6
% %                                 labels2 = '>100';
% %                             labels1 = '>100'; 
% %                         end
% %                  
%     
%              text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
%                             'VerticalAlignment','bottom')
%              text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
%                             'VerticalAlignment','bottom')
%               text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%                             'VerticalAlignment','bottom')
%                      text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%                             'VerticalAlignment','bottom')
%         
%                        ylim([0 210])
%     
%       
%     
%     
%                        kk = kk+1; 
%     
%     
%         
%         end             
%     
%     
%     end

end





