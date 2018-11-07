clear all
close all
t = load('satwat.txt');
tab = load('table.txt');
clc
fprintf("Calculating....\n");
for i=1:size(tab,1)
    if(~isnan(tab(i,1)))
        tab(i,2) = interpolation(tab(i,1),2,1,t);
    end
    if(~isnan(tab(i,2)))
        tab(i,1) = interpolation(tab(i,2),1,2,t);
    end
    if(~isnan(tab(i,1)))
        tab(i,5) = interpolation(tab(i,1),3,1,t);
        tab(i,6) = interpolation(tab(i,1),4,1,t);
        vf = tab(i,5);
        vg = tab(i,6);
        if(~isnan(tab(i,4)))
            v = tab(i,4);
            tab(i,3) = (v-vf)/(vg-vf);
        end
        if(~isnan(tab(i,7)))
            u = tab(i,7);
            temp = tab(i,1);
            uf = interpolation(temp,5,1,t);
            ug = interpolation(temp,6,1,t);
            tab(i,3) = (u-uf)/(ug-uf);
        end
        if(~isnan(tab(i,3)))
            x = tab(i,3);
            tab(i,4) = vf + x*(vg-vf);
        end
        if(isnan(tab(i,7)))
            temp = tab(i,1);
            uf = interpolation(temp,5,1,t);
            ug = interpolation(temp,6,1,t);
            tab(i,7) = uf + tab(i,3)*(ug-uf);
        end
    end
    if(isnan(tab(i,1)))
        x = tab(i,3);
        v = tab(i,4);
        for j=2:size(t,1)
            for k=t(j-1,1):0.8:t(j,1)
                vf = interpolation(k,3,1,t);
                vg = interpolation(k,4,1,t);
                v_cal = vf + x*(vg-vf);
                vs = v + (v/100);
                vi = v - (v/100);
                if(v_cal >= vi && v_cal <= vs)
                    tab(i,1) = k;
                    tab(i,2) = interpolation(k,2,1,t);
                    tab(i,5) = vf;
                    tab(i,6) = vg;
                    uf = interpolation(k,5,1,t);
                    ug = interpolation(k,6,1,t);
                    tab(i,7) = uf + x*(ug-uf);
                end
            end
        end
    end
end
path = which('proje.m');
path = strrep(path,'proje.m','result.txt');
f = fopen(path,'wt');
for i=1:size(tab,1)
   for j=1:size(tab,2)
      fprintf(f,'%5.5f\t\t',tab(i,j));
   end
   fprintf(f,'\n');
end

fprintf("Process complete...\n");
fclose(f);
