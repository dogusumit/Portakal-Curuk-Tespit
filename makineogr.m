clear,clc
close all

rgb=imread('a.jpg');
rgb=imresize(rgb, [480 640]);
figure
imshow(rgb);
title('Orjinal Resim');

hsv=rgb2hsv(rgb);
figure
imshow(hsv);
title('HSV Formatinda Resim');

h=hsv(: , : ,1);
s=hsv(: , : ,2);
v=hsv(: , : ,3);
figure
subplot(3,1,1)
imhist(h);
subplot(3,1,2)
imhist(s);
subplot(3,1,3)
imhist(v);
title('Histogram')

bw= (h>0.05 & h<0.12) & (s>0.6) & (v> 0.51);
figure
imshow(bw);
title('Ikili Esiklenmis Resim');

se = strel('disk',35);
bw = imclose(bw,se);
figure
imshow(bw);
title('Kapama Islemi Yapilmis Resim');

B = bwboundaries(bw); 
%siyah beyaz resimdeki bölgeleri bulur ve 
%bölgeye dahil pixelleri dizi olarak donurur(B)
figure
imshow(bw);
title(strcat('\color{green}Obje Sayýsý : ',num2str(length(B))));
%Bnin lenght i bizi obje sayýsýný verir
hold on

for k = 1:length(B)
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
%boundary x ve y ters oldugu icin plot yaparken x,y duzelt
end

obje_sayisi=length(B);
en_boy_orani=oran_hesapla(rgb);

%veriseti olusturma ve ekleme
if ~exist('veriseti')
    veriseti=[];
end
veriseti(end+1,:) = [obje_sayisi,en_boy_orani];
