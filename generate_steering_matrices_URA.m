function [ steering_matrix_A , steering_matrix_B, azimuths, elevations ] = generate_steering_matrices_URA( size_A , size_B )

%{

Funtion: Generate steering matrices URA.

Generate two steering matrices for a Uniform Rectangular Array - URA. 

Inputs: size_A -- [a b] -- row vector containing the dimensions of the desired steering matrix A. 
        size_B -- [a b] -- row vector containing the dimensions of the desired steering matrix B. 

Outputs: steering_matrix_A -- Matrix of size: a x b.
         steering_matrix_B -- Matrix of size: a x b.
         azimuths -- d angles of azimuth.
         elevations -- d angles of elevation.

Observations:

d is considered the model order.
Delta = lambda/2. Space between each sensors is equal to half of the wavelength of the signal.

%} 

%% Extract the desired dimensions.

M1 = size_A(1,1);
M2 = size_B(1,1);
d = size_A(1,2); % Must be also equal to size_B(1,2); 

%% Generation of random angles of arrival for azimuth and elevation. 

k1 = rand(d,1); 
azimuths = (k1.*pi) - (pi/2); % Limited from: -pi/2 to pi/2;

k2 = rand(d,1);
elevations = (k2.*pi) - (pi/2);

%% Generation of the spatial frequencies. Considering: Delta = lambda/2. 

spatial_freqs_r1 = pi * cos(azimuths) .* sin(elevations);
spatial_freqs_r2 = pi * sin(azimuths) .* sin(elevations);

%% Generation of the steering matrices.

steering_matrix_A = (0:1:M1-1)'*(spatial_freqs_r1');
steering_matrix_A = exp(1i * steering_matrix_A );

steering_matrix_B = (0:1:M2-1)'*(spatial_freqs_r2');
steering_matrix_B = exp(1i * steering_matrix_B); 

end

