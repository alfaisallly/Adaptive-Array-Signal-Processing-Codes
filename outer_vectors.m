function [ Tensor_Xo ] = outer_vectors( V1, V2, V3)
%PAFAFAC_OUTER Summary of this function goes here

%%  Extraction of the variables. 

[number_of_samples, d] = size(V3); % Dimensions of the third matrix. 
size_V1= size(V1); 
size_V2= size(V2); 
size_V3= size(V3); 

Tensor_Xo = zeros(size_V1(1,1), size_V2(1,1), size_V3(1,1)); % Output tensor. 

Face = zeros(size_V1(1,1), size_V2(1,1), size_V3(1,1)); % Intermadiate varible. 

%% Initialization of the algorithm. 

for i = 1:d 
    
    Aux = V1(:,i) * V2(:,i).';  % Matrix of the outer product between the vectors of the first two matrices.
    
        for k = 1:number_of_samples
        
            Face(:,:,k) = Aux * V3(k,i);
    
        end
    
    Tensor_Xo = Tensor_Xo + Face; 
        
    Face(:,:,:) = zeros(size_V1(1,1), size_V2(1,1), size_V3(1,1)); 
    
end
