
clear all
close all
% load images
location='C:\Users\user\Downloads\skin detection-key\';
D_original=dir([location '\image1\*.jpg']);
D_skin=dir([location '\image1\*skin.bmp']);
D_mask=dir([location '\image1\*mask.bmp']);


% training mask
skin=[];
non_skin=[];
for l=1:3 
    
    img_original=imread([location '\image1\' D_original(l).name]);
    img_mask=imread([location '\image1\' D_mask(l).name]);
    figure
    subplot(1,2,1)
    imshow(img_original)
    subplot(1,2,2)
    imshow(img_mask)
    img_original=double(img_original);
    [X,Y,Z]=size(img_original);
    for x=1:X
        for y=1:Y
            if img_mask(x,y,1)==255
                skin=[skin; img_original(x,y,1) img_original(x,y,2) img_original(x,y,3)];
            else
                non_skin=[non_skin; img_original(x,y,1) img_original(x,y,2) img_original(x,y,3)];
            end
        end
        if mod(x,5)==0
            l
            floor((x/X)*100)
        end
    end
    
end

save([location '\data\training_data7.mat'],'non_skin','skin')

