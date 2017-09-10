%clear all
%close all
% load images
location='C:\Users\user\Downloads\skin detection-key\';
D_original=dir([location '\image\*.jpg']);
D_skin=dir([location '\image\*skin.bmp']);
D_mask=dir([location '\image\*mask.bmp']);

% training/learning
load([location 'data\training_data8.mat' ]);
[u_skin,o_skin]=normfit(skin);
[u_non_skin,o_non_skin]=normfit(non_skin);
lamda=length(skin)/(length(skin)+length(non_skin));

% inferencing
img_original=imread([location '\image\' D_original(5).name]);
[X,Y,Z]=size(img_original);
img_result=zeros(X,Y);
img_original=double(img_original);
sigma_skin=[o_skin(1) 0 0
            0 o_skin(2) 0
            0 0 o_skin(3)];
sigma_non_skin=[o_non_skin(1) 0             0
                0             o_non_skin(2) 0
                0             0             o_non_skin(3)];        
for x=1:X
    for y=1:Y
        pixel=[img_original(x,y,1) img_original(x,y,2) img_original(x,y,3)];
        % probability of skin
        p_skin=mvnpdf(pixel,u_skin,sigma_skin)*lamda/((mvnpdf(pixel,u_skin,sigma_skin)*lamda+mvnpdf(pixel,u_non_skin,sigma_non_skin)*(1-lamda)));
        % probability of non_skinend
        p_non_skin=mvnpdf(pixel,u_non_skin,sigma_non_skin)*(1-lamda)/((mvnpdf(pixel,u_skin,o_skin)*lamda+mvnpdf(pixel,u_non_skin,sigma_non_skin)*(1-lamda)));
        if p_skin>p_non_skin
            img_result(x,y)=1;
        end
    end
end
imshow(img_result)
imwrite(img_result,'C:\Users\user\Downloads\skin detection-key\image\new_result.bmp')
    
% % skin=[];
% % non_skin=[];
% % for l=1:4 
% %     img_original=imread([location D_original(l).name]);
% %     img_mask=imread([location D_mask(l).name]);
% %     figure
% %     subplot(1,2,1)
% %     imshow(img_original)
% %     subplot(1,2,2)
% %     imshow(img_mask)
% %     img_original=double(img_original);
% %     [X,Y,Z]=size(img_original);
% %     for x=1:X
% %         for y=1:Y
% %             if img_mask(x,y,1)==255
% %                 skin=[skin; img_original(x,y,1) img_original(x,y,2) img_original(x,y,3)];
% %             else
% %                 non_skin=[non_skin; img_original(x,y,1) img_original(x,y,2) img_original(x,y,3)];
% %             end
% %         end
% %         if mod(x,50)==0
% %             x
% %         end
% %     end
% %     
% end



%[mu,sigma,muci,sigmaci] = normfit(data)