function h=computeHarmonic(t,c,omega0,n)

h=c*exp(1i*n*omega0*t)+...
       conj(c)*exp(-1i*n*omega0*t);
