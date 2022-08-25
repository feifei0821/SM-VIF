function Y=en(F)
[z,s]=size(F);
EN=0;
for i=1:256
    num=0;
    for j=1:z
        for k=1:s
            if F(j,k)==i
                num=num+1;
            end
        end
    end
    if num==0
        EN=EN+0;
    else
        EN=EN+(num/(z*s))*log2(num/(z*s));
    end
end
Y=-EN;
end