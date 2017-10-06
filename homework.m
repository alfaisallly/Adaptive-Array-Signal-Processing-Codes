%% Homework 1.  Caio C. R. Garcez.
clear all; 
clc; 

%% Parameters of the simulation . 
M1 = 5;
M2 = 6; 
d = 3; 
size_A = [M1 d]; 
size_B = [M2 d];
M = [M1 M2]; 
N = 8; 

%% Generation of the steering matrices. 
[A, B, elevations, azimuths] = generate_steering_matrices_URA(size_A, size_B);

% Sort the angles.
elevations = sort(elevations); 
azimuths = sort(azimuths); 

%% Generation of the signal matrice. 
S = ((1/sqrt(2)) * (randn(d,N) + 1i* randn(d,N)))';  

%% Generation of the tensor via outer product vectors.
Tensor_Xo_C = outer_vectors(A,B,S); 

Tensor_Xo = zeros(M1, M2, N); 

for k=1:d
    
    Tensor_Xo = Tensor_Xo + outer_product({outer_product({A(:,k), B(:,k)}), S(:,k)}); 
    
end

% Obtain the unfoldings of the tensor Xo. 
Xo1 = unfolding(Tensor_Xo, 1, d); 
Xo2 = unfolding(Tensor_Xo, 2, d); 
Xo3 = unfolding(Tensor_Xo, 3, d); 

%% DoA estimation via 2D-ESPRIT. 

% Obtain the signal subspace of the 3rd mode unfolding of the tensor. 
U_subspace = est_sigsubsp_classic(Xo3.', d);

estimated_spatial_frequencies = standard_esprit_Rd(U_subspace, M);

[estimated_elevations, estimated_azimuths] = solve_spatial_frequencies_URA(estimated_spatial_frequencies); 

% Sort the angles. 
estimated_elevations = sort(estimated_elevations); 
estimated_azimuths = sort(estimated_azimuths); 

    disp('______________________________________________________________');
    disp('DoA Estimation');
    disp(' ');

for i=1:d
    disp(['Elevation angle (' num2str(i) '): ' num2str(elevations(i,1)) ' rad']);  
end
    disp(' ');
for i=1:d
    disp(['Estimated elevation angle (' num2str(i) '): ' num2str(estimated_elevations(1,i)) ' rad']);  
end
    disp(' ');

 disp('______________________________________________________________');
for i=1:d
    disp(['Azimuth angle (' num2str(i) '): ' num2str(azimuths(i,1)) ' rad']);  
end
    disp(' ');
for i=1:d
    disp(['Estimated azimuth angle (' num2str(i) '): ' num2str(estimated_azimuths(1,i)) ' rad']);  
end
    disp(' ');

%% ALS Estimation. 

% Set the amount of iterations of the ALS algorithm. 
number_of_iterations = 350;
iterations = 1:number_of_iterations; 

% Inicialization of the matrices. Random estimation. 
[A_estimated, B_estimated] = generate_steering_matrices_URA(size_A, size_B); 

S_estimated = ((1/sqrt(2)) * (randn(d,N) + 1i* randn(d,N)))';

Error = []; 

% ALS algorithm.
for k=1:number_of_iterations    
   
   A_estimated = Xo1 * (pinv(krp(B_estimated,S_estimated))).';
    
   B_estimated = Xo2 * (pinv(krp(S_estimated,A_estimated))).';
    
   S_estimated = Xo3 * (pinv(krp(A_estimated,B_estimated))).';

   for kt=1:d
       
    Tensor_Xo_estimated = outer_product({outer_product({A_estimated(:,kt), B_estimated(:,kt)}), S_estimated(:,kt)}); 
   
   end
   
   Error(1,k) = ho_norm((Tensor_Xo - Tensor_Xo_estimated));  
   
end

% Plot the error of the estimation per iteractions.
plot(iterations, Error); 
title('ALS Result');
xlabel('Iteractions');
ylabel('Error');





 

