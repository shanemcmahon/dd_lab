#pragma rtGlobals=3		// Use modern global access method and strict wave access.
macro make_psf_figures(x_res, z_res)
variable x_res = 25
variable z_res = 150

newpath /O filepath, s_path 
LoadWave/J/D/A=wave/P=filepath/O/K=0/L={0,1,0,1,0} "psf1.csv"
LoadWave/J/D/A=wave/P=filepath/O/K=0/L={0,1,0,1,0} "psf2.csv"
LoadWave/J/D/A=wave/P=filepath/O/K=0/L={0,1,0,1,0} "psf3.csv"
LoadWave/J/D/A=wave/P=filepath/O/K=0/L={0,1,0,1,0} "psf4.csv"
LoadWave/J/D/A=wave/P=filepath/O/K=0/L={0,1,0,1,0} "psf5.csv"
setscale /p x,0, x_res, "nm", wave0
setscale /p x,0, x_res, "nm", wave1
setscale /p x,0, z_res, "nm", wave2
setscale /p x,0, z_res, "nm", wave3
setscale /p x,0, z_res, "nm", wave4
make /o /n=5 fwhm  
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
Display/K=0 wave3
CurveFit/M=2/W=0 gauss, wave3/D
ModifyGraph rgb(fit_wave3)=(0,0,0)
duplicate /o w_coef psf4
SavePICT/o/P=filepath/E=-5/B=288/win=graph3 as "psf4.png"
Display/K=0 wave4
CurveFit/M=2/W=0 gauss, wave4/D
ModifyGraph rgb(fit_wave4)=(0,0,0)
duplicate /o w_coef psf5
SavePICT/o/P=filepath/E=-5/B=288/win=graph4 as "psf5.png"

fwhm[0] = x_psf[3]
fwhm[1] = y_psf[3]
fwhm[2] = z_psf[3]
fwhm[3] = psf4[3]
fwhm[4] = psf5[3]
fwhm = fwhm*2.3548/(2^0.5)
Save/o/T/P=filepath x_psf,y_psf,z_psf,fwhm as "x_psf++.itx"
endmacro
