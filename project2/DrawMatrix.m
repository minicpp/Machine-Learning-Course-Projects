function [ ] = DrawMatrix( m )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m=reshape(m(:),[7,5]);
sizeM = size(m);
imageM = uint8(zeros([sizeM,3]));
lightColor=[252,210,10];
for i=1:sizeM(1)
    for j=1:sizeM(2)
        v = m(i,j);
        if v == 1
            imageM(i,j,:)=lightColor;
        end
    end
end
image(imageM);
hfig = imgcf
set(hfig, 'Position', [200, 200, 300, 420]);
set(gca,'XTick',1:sizeM(2))
set(gca,'YTick',1:sizeM(1))
grid on;
end

