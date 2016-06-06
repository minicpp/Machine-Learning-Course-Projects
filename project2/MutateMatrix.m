function [ m ] = MutateMatrix( m, p, bforce )
bMu = false;
sizeM = size(m);
s = length(m(:));
m=m(:);

while bMu == false
    if bforce == false
        bMu = true; % just loop once
    end
    for i=1:s
        v = rand();
        mv = m(i);
        if v<= p
            bMu = true;
            if mv == 0
                m(i) = 1;
            else
                m(i) = 0;
            end
        end
    end
end
m = reshape(m,sizeM);
end

