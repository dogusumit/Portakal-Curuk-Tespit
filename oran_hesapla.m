function en_boy_orani=oran_hesapla(rgb)
figure
subplot(2,2,1)
imshow(rgb);
title('Orjinal Resim');

hsv=rgb2hsv(rgb);
subplot(2,2,2)
imshow(hsv);
title('HSV Formatýnda Resim');

h=hsv(: , : ,1);
s=hsv(: , : ,2);
v=hsv(: , : ,3);
bw= (h>0.05 & h<0.12) & (s>0.6) & (v> 0.51);
subplot(2,2,3)
imshow(bw);
title('Ýkili Eþiklenmiþ Resim');

resim=1-bw;
konum=zeros(1,4);
bulduk=false;
for i=1:size(resim,1)
    for j=1:size(resim,2)
        if resim(i,j)==0
            konum(1)=i;
            bulduk=true;
            break;
        end
        if bulduk==true
            break;
        end
    end
end
bulduk=false;
for i=size(resim,1):-1:1
    for j=1:size(resim,2)
        if resim(i,j)==0
            konum(2)=i;
            bulduk=true;
            break;
        end
        if bulduk==true
            break;            
        end
    end
end
bulduk=false;
for i=1:size(resim,2)
    for j=1:size(resim,1)
        if resim(j,i)==0
            konum(3)=i;
            bulduk=true;
            break;
        end
        if bulduk==true
            break;
        end
    end
end
bulduk=false;
for i=size(resim,2):-1:1
    for j=1:size(resim,1)
        if resim(j,i)==0
            konum(4)=i;
            bulduk=true;
            break;
        end
        if bulduk==true
            break;
        end
    end
end
resim=resim(konum(1):konum(2),konum(3):konum(4));
subplot(2,2,4)
imshow(resim);
title('Týraþlanmýþ Resim');

en_boy_orani=size(resim,1)/size(resim,2);
end
