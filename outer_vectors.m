function [ Tensor_Xo ] = outer_vectors( V1, V2, V3)
%PAFAFAC_OUTER Summary of this function goes here
%   Detailed explanation goes here

[number_of_samples, d] = size(V3); % Dimensions of the third matrix. 

Tensor_Xo = zeros(5, 6, 8); % Inicialization of the output tensor. 

for i = 1:d 
    % Matrix of the outer product between the vectors of the first two matrices.
    AUX = V1(:,i) * V2(:,i).'; 
    
    Tensor_Xo_aux = zeros(5, 6, 8);  % Inicialization of the auxiliar tensor.
    
for k = 1:number_of_samples % ammount of lines of the matrix V3. 
    
    Tensor_Xo_aux(:,:,k) = AUX * V3(k,d); % Obtain a rank1 tensor. 
    
end

Tensor_Xo = Tensor_Xo + Tensor_Xo_aux; % Sum of the d rank1 vectors. 

end
