function h=computeHarmonic(t,c,omega0,n)

if n==0
    h=c*ones(length(t),1);
else
    h=c*exp(1i*n*omega0*t)+...
        conj(c)*exp(-1i*n*omega0*t);
end