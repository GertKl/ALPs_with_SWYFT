#!/usr/bin/env python3
# -*- coding: utf-8 -*-

def param_function(params):

	 full_par = [
	 		10, 	 # mass m in neV
	 		params[0], 	 # coupling constant g in 10^(-11) /GeV

	 		1.54e-09, 	 # Amplitude of power law, in TeV-1 cm-2 s-1
	 		2.11, 	 # Spectral index of the PWL

	 		300, 	 # Reference energy (?) E0, In GeV
	 		560, 	 # Cut-off energy Ecut, in GeV
	 		25, 	 # rms of B field, default = 10.
	 		39, 	 # normalization of electron density, default = 39.
	 		4.05, 	 # second normalization of electron density, see Churazov et al. 2003, Eq. 4, default = 4.05
	 		500, 	 # extension of the cluster, default = 500.
	 		80, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 80.
	 		280, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 200.
	 		1.2, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 1.2
	 		0.58, 	 # electron density parameter, see Churazov et al. 2003, Eq. 4, default = 0.58
	 		0.5, 	 # scaling of B-field with electron denstiy, default = 0.5
	 		0.18, 	 # maximum turbulence scale in kpc^-1, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 0.18
	 		9, 	 # minimum turbulence scale, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = 9.
	 		-2.8  	 # turbulence spectral index, taken from A2199 cool-core cluster, see Vacca et al. 2012, default = -2.80
	 	]

	 return full_par



param_names=['g']



param_units=['1e-11GeV^-1']