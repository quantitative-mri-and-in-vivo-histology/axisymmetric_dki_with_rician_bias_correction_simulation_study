function [design_kurtosis]  = simulation_design_matrix_standardDKI(V,bvalue)


% design matrix diffusion tensor
X2(1,:)  = V(1,:).^2;
X2(2,:)  = V(2,:).^2;
X2(3,:)  = V(3,:).^2;

X2(4,:)  = 2*V(1,:).*V(2,:);
X2(5,:)  = 2*V(1,:).*V(3,:);
X2(6,:)  = 2*V(2,:).*V(3,:);
X2(7,:)  = 1;
% design matrix kurtosis tensor
X4(1,:)  = V(1,:).^4; % V_1111
X4(2,:)  = V(2,:).^4; % V_2222
X4(3,:)  = V(3,:).^4; % V_3333

X4(4,:)  = 4*V(1,:).^3.*V(2,:); % V_1112
X4(5,:)  = 4*V(1,:).^3.*V(3,:); % V_1113
X4(6,:)  = 4*V(2,:).^3.*V(1,:); % V_2221
X4(7,:)  = 4*V(3,:).^3.*V(1,:); % V_3331
X4(8,:)  = 4*V(2,:).^3.*V(3,:); % V_2223
X4(9,:)  = 4*V(3,:).^3.*V(2,:); % V_3332
X4(10,:) = 6*V(1,:).^2.*V(2,:).^2; % V_1122
X4(11,:) = 6*V(1,:).^2.*V(3,:).^2; % V_1133
X4(12,:) = 6*V(2,:).^2.*V(3,:).^2; % V_2233
X4(13,:) = 12*V(1,:).^2.*V(2,:).*V(3,:); % V_1123 = V_permut(1132)
X4(14,:) = 12*V(2,:).^2.*V(1,:).*V(3,:); % V_2213
X4(15,:) = 12*V(3,:).^2.*V(1,:).*V(2,:); % V_3312


szb = size(bvalue);
if(szb(1)==1)
%   normalization of bvalues
%    nbvalue = bval/max(bval);
    nbvalue = bvalue;
    mb      = min(nbvalue);    
    bmax    = max(nbvalue);
    bMSK    = find(nbvalue>mb);
    XX2     = bsxfun(@times,X2, nbvalue);
    XX2(7,:) = -1; % this entry is corresponding to the ln(S0) part in the parameter vector
    XX4     = bsxfun(@times,X4, (nbvalue.^2)/6);
    XX      = cat(1,-XX2,XX4);
%     XX      = XX(:,bMSK);
else
    error('This version cannot handle b-values other than of the form: 1xN')
end
design_kurtosis = XX';