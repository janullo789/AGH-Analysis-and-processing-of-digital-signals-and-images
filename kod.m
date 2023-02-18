close all; clear; clc;

%imtool('skala_20x.jpg');

N18 = imread('31_180_1N.jpg');
XN18o = imread('31_180_XN.jpg');
XN21 = imread('31_210_XN.jpg');
XN21 = imrotate(XN21, -30, 'crop');
XN24 = imread('31_240_XN.jpg');
XN24 = imrotate(XN24, -60, 'crop');
XN27 = imread('31_270_XN.jpg');
XN27 = imrotate(XN27, -90, 'crop');
XN30 = imread('31_300_XN.jpg');
XN30 = imrotate(XN30, -120, 'crop');
XN33 = imread('31_330_XN.jpg');
XN33 = imrotate(XN33, -150, 'crop');

subplot(231); imshow(N18);
subplot(232); imshow(XN18o);
subplot(233); imshow(XN21);
subplot(234); imshow(XN24);
subplot(235); imshow(XN27);
subplot(236); imshow(XN30);

%------------ glaukonit --------------------

bin = (N18(:,:,1)>65 & N18(:,:,1)<100) & (N18(:,:,2)>75 & N18(:,:,2)<110) & (N18(:,:,3)>45 & N18(:,:,3)<90);

bin = imfill(bin,'holes'); %zapełninie "dziur"
glaukonit=bwareaopen(bin,100); %usuniecie małych elementów
glaukonit=imclose(glaukonit, strel('disk',19)); %usuniecie szumu
glaukonit=imopen(glaukonit, strel('disk',19));
glaukonit=imfill(glaukonit,'holes'); %zapełnienie "dziur"
glaukonit=imdilate(glaukonit, strel('line', 10,150)); %delacja

elementyBin = uint8(glaukonit).*N18;
tloBin = uint8(~glaukonit).*N18;

subplot(231); imshow(N18);
subplot(232); imshow(XN18o);
subplot(233); imshow(bin);
subplot(234); imshow(glaukonit);
subplot(235); imshow(elementyBin);
subplot(236); imshow(tloBin);

%usuniecie ze zdjecia zidentyfikowane minerały
tloN18 = tloBin;
XN18 = uint8(~glaukonit).*XN18o;

samGlaukonitN = elementyBin;
samGlaukonitXN = uint8(glaukonit).*XN18o;

subplot(231); imshow(tloN18);
subplot(232); imshow(XN18);

% ------------- znalezienie przezroczystych minerałów na N18 ------------

bin = (tloN18(:,:,1)>100 & tloN18(:,:,1)<200) & (tloN18(:,:,2)>100 & tloN18(:,:,2)<200) & (tloN18(:,:,3)>100 & tloN18(:,:,3)<200);

%imtool(N18);

tlo=bin;
tlo=imclose(tlo, strel('disk',5));
tlo=imopen(tlo, strel('disk',5));

tloBin = uint8(tlo).*N18;
elementyBin = uint8(~tlo).*N18;

subplot(231); imshow(N18);
subplot(232); imshow(XN18);
subplot(233); imshow(bin);
subplot(234); imshow(tlo);
subplot(235); imshow(elementyBin);
subplot(236); imshow(tloBin);

szareN = tlo;
subplot(236); imshow(szareN);

% -------- usuniecie jasnoszarych oraz szarych elementów zdjecia XN

pXN18 = uint8(tlo).*XN18; %wybieram elementy ze zdjecia XN18 które są przezroczyste na zdjeciu N18
subplot(236); imshow(pXN18);

% - dla czerwnoego wybieram wartości +100 (dlatego żeby nie usunać elementów
% czarnych
%  - dla zielonego i niebieskiego wybieram wartości z przedziału 0.9 - 1.1
%  wartosci koloru czerownego, ponieważ kolor szary ma zblizone wartości
%  dla wszystkich kolorów.
bin = pXN18(:,:,1)>100 & pXN18(:,:,1)<=255 & pXN18(:,:,2)>pXN18(:,:,1)*0.9 & pXN18(:,:,2)<XN18(:,:,1)*1.1 & pXN18(:,:,3)>XN18(:,:,1)*0.9 & pXN18(:,:,3)<XN18(:,:,1)*1.1;

bin = imfill(bin,'holes'); %zapełninie "dziur"
szareXN = bin;
szareXN=imclose(szareXN, strel('disk',7)); %usuniecie szumu
szareXN=imopen(szareXN, strel('disk',7));
szareXN=imdilate(szareXN, strel('line', 10,150)); %delacja

elementyBin = uint8(szareXN).*pXN18;
tloBin = uint8(~szareXN).*pXN18;

subplot(231); imshow(N18);
subplot(232); imshow(pXN18);
subplot(233); imshow(bin);
subplot(234); imshow(szareXN);
subplot(235); imshow(elementyBin);
subplot(236); imshow(tloBin);

koloryXN18 = tloBin; %zdjecie XN z wyciętymi szarymi elementami ze zdjecia pXN18

% -------- węglany ---------

bin = (koloryXN18(:,:,1)>110 & koloryXN18(:,:,1)<=255) & (koloryXN18(:,:,2)>60 & koloryXN18(:,:,2)<255) & (koloryXN18(:,:,3)>60 & pXN18(:,:,3)<255);

bin = imfill(bin,'holes'); %zapełninie "dziur"
weglany=bwareaopen(bin,50);
weglany=imclose(weglany, strel('disk',19));
weglany=imopen(weglany, strel('disk',19));
weglany=imdilate(weglany, strel('line', 30,150)); %delacja

elementy = uint8(weglany).*koloryXN18;
tlo = uint8(~weglany).*koloryXN18;

subplot(231); imshow(N18);
subplot(232); imshow(koloryXN18);
subplot(233); imshow(bin);
subplot(234); imshow(weglany);
subplot(235); imshow(elementy);
subplot(236); imshow(tlo);

samWeglanyXN = elementy;
samWeglanyN = uint8(weglany).*N18;

% ----- kwarc ----

% kwarcu szukam na N18. Z poczatkowego N18 usuwam glaukonit, weglany, oraz
% uwzgledniamy tylko przezroczyste elemanty z N18.

reszta = ~glaukonit .* ~weglany .* szareN;
resztaN = uint8(~glaukonit) .* uint8(~weglany) .* uint8(szareN) .* N18;
resztaXN = uint8(~glaukonit) .* uint8(~weglany) .* uint8(szareN) .* XN18;

bin = resztaXN(:,:,2)>resztaXN(:,:,1)*0.9 & resztaXN(:,:,2)<resztaXN(:,:,1)*1.1 & resztaXN(:,:,3)>resztaXN(:,:,1)*0.9 & resztaXN(:,:,3)<resztaXN(:,:,1)*1.1;

bin = imfill(bin,'holes'); %zapełninie "dziur"
kwarc = bin;
kwarc=imclose(kwarc, strel('disk',7)); %usuniecie szumu
kwarc=imopen(kwarc, strel('disk',7));
kwarc=imdilate(kwarc, strel('line', 10,150)); %delacja

elementyBin = uint8(kwarc).*XN18o;
tloBin = uint8(~kwarc).*pXN18;

samKwarcN = uint8(kwarc).*N18;
samKwarcXN = uint8(kwarc).*XN18o;

subplot(236); imshow(tloBin);

% ---- wyniki ----

subplot(3,4,1); imshow(N18);
subplot(3,4,2); imshow(samGlaukonitN);
subplot(3,4,3); imshow(samWeglanyN);
subplot(3,4,4); imshow(samKwarcN);
subplot(3,4,5); imshow(XN18o);
subplot(3,4,6); imshow(samGlaukonitXN);
subplot(3,4,7); imshow(samWeglanyXN);
subplot(3,4,8); imshow(samKwarcXN);
subplot(3,4,10); imshow(glaukonit);
subplot(3,4,11); imshow(weglany);
subplot(3,4,12); imshow(kwarc);

pole_glaukonit = sum(glaukonit(:)) * ((500/933)*0.001)^2
pole_weglany = sum(weglany(:)) * ((500/933)*0.001)^2
pole_kwarc = sum(kwarc(:)) * ((500/933)*0.001)^2

