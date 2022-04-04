function output=computeOutputFromHarmonics(t,c,omega0,n)


output=zeros(length(t),1);
for idx=1:length(n)
    h=computeHarmonic(t,c(idx),omega0,n(idx));
    output=output+h;
end