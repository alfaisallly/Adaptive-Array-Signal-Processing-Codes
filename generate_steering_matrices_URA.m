function [ steering_matrix_A , steering_matrix_B, azimuths, elevations ] = generate_steering_matrices_URA( size_A , size_B )
% --------------------------------------------------------------------------------------
% Generate a steering matrix for a uniform rectangular array with size: rows x collumns. 
% The scenario considers Delta = Lambda/2. 

%% Extraction of the parameters. 
M1 = size_A(1,1);
M2 = size_B(1,1);
d = size_A(1,2); 

%% Generation of random angles of arrival for azimuth and elevation. 
k1 = rand(d,1); 
azimuths = (k1.*pi) - (pi/2); 

k2 = rand(d,1);
elevations = (k2.*pi) - (pi/2);

%% Generation of the spatial frequencies. 
spatial_freqs_r1 = pi * cos(azimuths) .* sin(elevations);
spatial_freqs_r2 = pi * sin(azimuths) .* sin(elevations);

%% Generation of the steering matrices.
steering_matrix_A = (0:1:M1-1)'*(spatial_freqs_r1');
steering_matrix_A = exp(1i * steering_matrix_A );

steering_matrix_B = (0:1:M2-1)'*(spatial_freqs_r2');
steering_matrix_B = exp(1i * steering_matrix_B); 

end

