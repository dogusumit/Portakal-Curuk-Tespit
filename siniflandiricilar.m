veriseti=[randi(2,100,1),rand(100,1)+0.5];
%verisetini 100 tane random degerle doldurdum, sanki 100 tane portakal
%resmi için makineogr.m kodunu çalýþtýrmýþým gibi
%test verisetini de 20 tane random degerle doldurdum, sanki makineogr.m
%kodunda "veriseti" yazan yerleri "test_veriseti" ile degistirip 20 tane
%portakal resmiyle çalýþtýrmýþým gibi

test_veriseti = [randi(2,20,1),rand(20,1)+0.5];
%basarimi olcmek icin test_verisetine gelen portakallarýn gerçek
%sýnýflarýný da bilmem gerek, o yüzden random oluþturdum sanki tek tek elle
%sýnýflarý girmiþim gibi
test_siniflari = randi(4,20,1);

%kmeans
[siniflar,kume_mer] = kmeans(veriseti,4);
figure;
% herbir sinif farklý renkte olacak þekilde ekrana yazdýrdýk
plot(veriseti(siniflar==1,1),veriseti(siniflar==1,2),'r.','MarkerSize',12)
hold on
plot(veriseti(siniflar==2,1),veriseti(siniflar==2,2),'b.','MarkerSize',12)
plot(veriseti(siniflar==3,1),veriseti(siniflar==3,2),'g.','MarkerSize',12)
plot(veriseti(siniflar==4,1),veriseti(siniflar==4,2),'y.','MarkerSize',12)
title 'Kmeans Sýnýflandýrýcý';
hold off


%knn
T1 = knnclassify (test_veriseti, veriseti, siniflar, 3);
basarim(test_siniflari, T1);

%bayes
%bayes,ann gibileri denetimli miydi  neydi, yani verisetinin sýnýflarýný da
%söylememiz lazým tabi elle oluþturmayýp random yapacam
veriseti_siniflari = randi(4,100,1);

O1 = NaiveBayes.fit(veriseti, veriseti_siniflari);
T2 = O1. predict(test_veriseti);
basarim(test_siniflari, T2);

%ann

net = patternnet(4);
[net,tr] = train(net,veriseti',veriseti_siniflari');
T3 = round (net(test_veriseti') );
basarim(test_siniflari, T3);

%random forest

agacsayisi = 4;
orman = TreeBagger(agacsayisi,veriseti,veriseti_siniflari, 'Method', 'classification');
view(orman.Trees{1},'mode','graph');
T4 = str2double(orman.predict(test_veriseti));
basarim(test_siniflari, T4);

%svm
%svm sadece 2 sýnýfý ayýrt edecegi icin once yafa-waþ sýnýflandýrma sonra
%saglam curuk sýnýflandýrma yaptýk, bunun için verisetini 1-2'ler ve
%3-4'ler olmak uzere 2 ye ayýrdýk

veriseti_yafa_was = veriseti(siniflar<=2,:);
veriseti_siniflari_yafa_was = siniflar(siniflar<=2,:);
svmStruct1 = svmtrain(veriseti_yafa_was,veriseti_siniflari_yafa_was,'ShowPlot',true);

veriseti_saglam_curuk = veriseti(siniflar>=3,:);
veriseti_siniflari_saglam_curuk = siniflar(siniflar>=3,:);
svmStruct2 = svmtrain(veriseti_saglam_curuk,veriseti_siniflari_saglam_curuk,'ShowPlot',true);

