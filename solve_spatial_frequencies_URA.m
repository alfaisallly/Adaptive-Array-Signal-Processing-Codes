function [ estimated_elevations, estimated_azimuths ] = solve_spatial_frequencies_URA( estimated_spatial_frequencies )
%   
%   Obtain the estimated angles of elevation and azimuth of the URA. 

estimated_elevations= acot(estimated_spatial_frequencies(1,:)./estimated_spatial_frequencies(2,:));
estimated_azimuths = asin(estimated_spatial_frequencies(2,:)./(sin(estimated_elevations)*pi));

end

