function image_rotation(image_name,image_path,about_y,angle)

path = image_path + '\' + image_name ;
img = imread(path);
 
if(about_y)
    rot_mat = [cosd(angle) -sind(angle); sind(angle) cosd(angle)];
else
    rot_mat = rotx(angle);
end
image_height = size(img,1);
image_width = size(img,2);


final_img = uint8(zeros(image_height,image_width,3));
for i = 0:image_height-1
    for j = 0:image_width-1
        new_cor = [(image_height/2)-i,j-(image_width/2)];
        old_cord = rot_mat\new_cor';    
        old_cord(1) = image_height/2 - old_cord(1);
        old_cord(2) = old_cord(2)+image_width/2  ;
        %disp(old_cord)
         if(old_cord(1)<image_height-1 && old_cord(2)< image_width-1 && old_cord(1)>0 && old_cord(2) > 0)
             final_img(i+1,j+1,:) = img(round(old_cord(1)+1),round(old_cord(2)+1),:);
         end
    end
end
figure;
imshow(img);
hold on;
figure;
imshow(final_img);
hold on;
end
