#pragma rtGlobals=3		// Use modern global access method and strict wave access.
macro make_psf_figures(x_res, z_res)
variable x_res = 25
variable z_res = 150

newpath /O filepath, s_path 
setscale /p x,0, x_res, wave0
setscale /p x,0, x_res, wave1
setscale /p x,0, z_res, wave2
make /o /n=3 fwhm  
Display/K=0 wave0
CurveFit/M=2/W=0 gauss, wave0/D
ModifyGraph rgb(fit_wave0)=(0,0,0)
duplicate /o w_coef x_psf
SavePICT/o/P=filepath/E=-5/B=288/win=graph0 as "x_psf.png"
Display/K=0 wave1
CurveFit/M=2/W=0 gauss, wave1/D
ModifyGraph rgb(fit_wave1)=(0,0,0)
duplicate /o w_coef y_psf
SavePICT/o/P=filepath/E=-5/B=288/win=graph1 as "y_psf.png"
Display/K=0 wave2
CurveFit/M=2/W=0 gauss, wave2/D
ModifyGraph rgb(fit_wave2)=(0,0,0)
duplicate /o w_coef z_psf
SavePICT/o/P=filepath/E=-5/B=288/win=graph2 as "z_psf.png"

fwhm[0] = x_psf[3]
fwhm[1] = y_psf[3]
fwhm[2] = z_psf[3]
fwhm = fwhm*2.3548
Save/o/T/P=filepath x_psf,y_psf,z_psf,fwhm as "x_psf++.itx"
endmacro
