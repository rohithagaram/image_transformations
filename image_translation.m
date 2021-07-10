function image_translation(image_path,image_name,x_trans,y_trans)

path = image_path + '\' + image_name ;
img = imread(path);
y_trans = -(y_trans); % converting  offest to image coordinate offest

trans_mat = [1 0 x_trans;0 1 y_trans;0 0 1];
image_height = size(img,1);
image_width = size(img,2);

width_new = image_width + abs(x_trans);
height_new = image_height + abs(y_trans) ;
final_img = (uint8(ones(height_new,width_new,3)));

for i = 0:width_new-1
    for j = 0:height_new-1
        new_cord = [i+(x_trans*(x_trans<0)),j+(y_trans*(y_trans<0)),1]; 
        old_cord = trans_mat\new_cord'; 
        old_cord_n = [old_cord(2),old_cord(1)];
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