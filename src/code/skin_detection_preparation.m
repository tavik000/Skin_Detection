clear all
close all

img=imread('C:\Users\user\Downloads\skin detection-key\image1\03_skin.bmp');
imshow(img)
[M,N,L]=size(img)

mask=zeros(M,N);
for m=1:M
    for n=1:N
        if img(m,n,1)~=255||img(m,n,2)~=255||img(m,n,3)~=255
            mask(m,n)=1;
        end
    end
end
figure
imshow(mask)
imwrite(mask,'C:\Users\user\Downloads\skin detection-key\image1\03_mask.bmp');
            