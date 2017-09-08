veriseti=[randi(2,100,1),rand(100,1)+0.5];
%verisetini 100 tane random degerle doldurdum, sanki 100 tane portakal
%resmi i�in makineogr.m kodunu �al��t�rm���m gibi
%test verisetini de 20 tane random degerle doldurdum, sanki makineogr.m
%kodunda "veriseti" yazan yerleri "test_veriseti" ile degistirip 20 tane
%portakal resmiyle �al��t�rm���m gibi

test_veriseti = [randi(2,20,1),rand(20,1)+0.5];
%basarimi olcmek icin test_verisetine gelen portakallar�n ger�ek
%s�n�flar�n� da bilmem gerek, o y�zden random olu�turdum sanki tek tek elle
%s�n�flar� girmi�im gibi
test_siniflari = randi(4,20,1);

%kmeans
[siniflar,kume_mer] = kmeans(veriseti,4);
figure;
% herbir sinif farkl� renkte olacak �ekilde ekrana yazd�rd�k
plot(veriseti(siniflar==1,1),veriseti(siniflar==1,2),'r.','MarkerSize',12)
hold on
plot(veriseti(siniflar==2,1),veriseti(siniflar==2,2),'b.','MarkerSize',12)
plot(veriseti(siniflar==3,1),veriseti(siniflar==3,2),'g.','MarkerSize',12)
plot(veriseti(siniflar==4,1),veriseti(siniflar==4,2),'y.','MarkerSize',12)
title 'Kmeans S�n�fland�r�c�';
hold off


%knn
T1 = knnclassify (test_veriseti, veriseti, siniflar, 3);
basarim(test_siniflari, T1);

%bayes
%bayes,ann gibileri denetimli miydi  neydi, yani verisetinin s�n�flar�n� da
%s�ylememiz laz�m tabi elle olu�turmay�p random yapacam
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
%svm sadece 2 s�n�f� ay�rt edecegi icin once yafa-wa� s�n�fland�rma sonra
%saglam curuk s�n�fland�rma yapt�k, bunun i�in verisetini 1-2'ler ve
%3-4'ler olmak uzere 2 ye ay�rd�k

veriseti_yafa_was = veriseti(siniflar<=2,:);
veriseti_siniflari_yafa_was = siniflar(siniflar<=2,:);
svmStruct1 = svmtrain(veriseti_yafa_was,veriseti_siniflari_yafa_was,'ShowPlot',true);

veriseti_saglam_curuk = veriseti(siniflar>=3,:);
veriseti_siniflari_saglam_curuk = siniflar(siniflar>=3,:);
svmStruct2 = svmtrain(veriseti_saglam_curuk,veriseti_siniflari_saglam_curuk,'ShowPlot',true);

