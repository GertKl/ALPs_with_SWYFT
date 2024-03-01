#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def param_function(params):

	 full_par = [
	 		10, 	 # mass m in neV
	 		params[0], 	 # coupling constant g in 10^(-11) /GeV

	 		10, 	 # Amplitude of power law, in TeV-1 cm-2 s-1
	 		10, 	 # Spectral index of the PWL

	 		10, 	 # Reference energy (?) E0, In GeV
	 		10, 	 # Cut-off energy Ecut, in GeV
	 		10, 	 # rms of B field, default = 10.
	 		10, 	 # normalization of electron density, default = 39.
	 		10, 	 # second normalization of electron density, see Churazov et al. 2003, Eq. 4, default = 4.05
	 		10, 	 # extension of the cluster, default = 500.
	 		10, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 80.
	 		10, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 200.
	 		10, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 1.2
	 		10, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 0.58
	 		10, 	 # scaling of B-field with electron denstiy, default = 0.5
	 		10, 	 # maximum turbulence scale in kpc^-1, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 0.18
	 		10, 	 # minimum turbulence scale, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 9.
	 		10  	 # turbulence spectral index, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = -2.80
	 	]

	 return full_par



param_names=['g']



param_units=['1e-11GeV^-1']