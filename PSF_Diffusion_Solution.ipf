#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
//diffusion equations for initially gaussian distributed concentration
//the equations given are only valid for radially symmetric gaussians (sigma_x == sigma_y) and within the z = 0 plane
variable sx = 0.3 //sigma x/y in µm
variable sz = 1 //sigma z in µm
variable D = 1 //diffusion coeff in µm^2/s
variable M = 1 //scaling factor (nominally the amount of diffusing substance)

make /n=1000 r_,t_
r_ = x/1000
t_=x/1000

//concentration as a function of radius and time
duplicate r_,Concentration
Concentration = M*(((sx^2)*sz*exp( (-2*r_^2)/(4*D*t_ + 2*sx^2) )) / ( (2*D*t_ + sx^2) * sqrt(2*D*t_ + sz^2) ))

//concentration at r = 0.221622 µm, t = (0,100) ms
r_ = 0.221622
setscale /i x,0,0.1,t_
t_ = x
Concentration = M*(((sx^2)*sz*exp( (-2*r_^2)/(4*D*t_ + 2*sx^2) )) / ( (2*D*t_ + sx^2) * sqrt(2*D*t_ + sz^2) ))
display Concentration vs t_

//For local extrema we have the contion dC(r_,t_)/dt_ = 0
//after some rearrangement, the condition yields r_(t_) as:
setscale /i x,0,0.01,t_
t_ = x
r_ = sqrt( (2*D*t_+sx^2) + ((2*D*t_+sx^2)^2)/(2*(2*D*t_+sz^2)) )
//putting t_ and r_(t_) back into C(r_,t_) yields concentration extrema as a function of t_
duplicate /o Concentration, C_Max_t
C_Max_t = M*(((sx^2)*sz*exp( (-2*r_^2)/(4*D*t_ + 2*sx^2) )) / ( (2*D*t_ + sx^2) * sqrt(2*D*t_ + sz^2) ))
display C_Max_t vs t_

//Compare the extreme value we calculated to the values at r_=0
duplicate /o C_Max_t,C0
r_=0
C0 = M*(((sx^2)*sz*exp( (-2*r_^2)/(4*D*t_ + 2*sx^2) )) / ( (2*D*t_ + sx^2) * sqrt(2*D*t_ + sz^2) ))
appendtograph C0 vs t_
//Notice that C0 > C_Max_t. This is not an error in the formula. 
//C_Max_t would more properly be referred to as C_Local_Extrema_t.
//For any point r_ that attains it's maximum concentration at t_==0 
// never satisfies the condition dC/dT == 0

//using the same condition we can express t_(r_) as:
variable a,0
duplicate /o r_,b,c
setscale /i x,0,0.3,r_
r_ = x
a = 12*D^2
b = 4*D*(2*sx^2 + sz^2 - r_^2)
c = sx^4 + (sx^2)*(sz^2) - 2*(r_^2)*(sz^2)
t_ = (-b + sqrt(b^2 - 4*a*c))/(2*a)

duplicate /o Concentration, C_Max_r
C_Max_r = M*(((sx^2)*sz*exp( (-2*r_^2)/(4*D*t_ + 2*sx^2) )) / ( (2*D*t_ + sx^2) * sqrt(2*D*t_ + sz^2) ))
//notice now that for small r_ the estimated c_max is too large
// (note also that the corresponding times are negative) 
Display C_max_r vs r_
edit t_
duplicate t_,abs_T
abs_T = abs(t_)
wavestats abs_T
print r_[v_minrowLoc]

