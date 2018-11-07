function x = interpolation(y,m,z,t)
    control = 0;
    for i=2:size(t,1)
        if(t(i,z)>=y && t(i-1,z)<=y)
            control = 1;
            w_1=(y-t(i-1,z))/(t(i-1,z)-t(i,z));
            w_2 = t(i-1,m) - t(i,m);
            x = w_1*w_2 + t(i-1,m);
        end
    end
    if(control == 0)
        x = 0;
    end
end