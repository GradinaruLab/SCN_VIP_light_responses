function [n_photons] = Get_wavelength_n_photons (wavelength,power)
% wavelength in nm, power in mW 

% correct for detecor dimentions S120C Thorlabs
power=power/0.9409;

% calculate freq of wavelength
f=(3*10^10)/(wavelength*10^-9);%freq[s]=c[m/s]/lambda[m] , wavelength in nm

n_photons=((power*10^-3)*1)/((6.626*10^-34)*f); % n=E/h*nee, power in mW=mJ/s  h is 6.626*10^-34 J*s. nee is f [1/s] 
