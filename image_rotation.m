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

% border calculation
tl = [0,0];
tr = [size(img,2)-1,0];
bl = [0,size(img,1)-1];
br =  [size(img,2)-1,size(img,1)-1];
boundaries = [tl;tr;bl;br];
new_boundaries=[];
for m = 1: size(boundaries,1)
    point = [boundaries(m,1)- (image_width/2),(image_height/2)-boundaries(m,2)];
    new_point = rot_mat * point';
    new_point(1)  = new_point(1)+image_width/2  ;
    new_point(2) = image_height/2 - new_point(2);
    new_boundaries = [new_boundaries,new_point];
end

width_new = round(max(new_boundaries(1,:)) -  min(new_boundaries(1,:)));
height_new = round(max(new_boundaries(2,:)) -  min(new_boundaries(2,:))) ;

final_img = uint8(zeros(height_new,width_new,3));

for i = 0:width_new-1
    for j = 0:height_new-1
        new_cor_mid = [i-(width_new/2),(height_new/2)-j]; % top to mid new_frame
        new_cor_ref = new_cor_mid; % mid new frame to mid old frame
        old_cord = rot_mat\new_cor_ref';  % new rotation point in the old frame
        old_2_new_cor(2) = image_height/2 - old_cord(2); %  old frame mid -> top
        old_2_new_cor(1) = old_cord(1)+image_width/2  ;
        old_cord_n = [old_2_new_cor(2),old_2_new_cor(1)];
        if(old_cord_n(1)<image_height-1 && old_cord_n(2)< image_width-1 && old_cord_n(1)>0 && old_cord_n(2) > 0)
             final_img(j+1,i+1,:) = img(round(old_cord_n(1)+1),round(old_cord_n(2)+1),:);
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
