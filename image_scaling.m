function image_transformation (image_name,image_path,operation,scale_factor,x_scale,y_scale)

  path = image_path + "\" +image_name ;
  input_img = imread(path);
  height = size(input_img,1);
  width = size(input_img,2);
  figure ;
  imshow(input_img);
  hold on;
  if(operation == "uniform_scale") 
      scaled_width = round(width/scale_factor);
      scaled_height = round(height/scale_factor);
      final_img = uint8(zeros(scaled_height,scaled_width,3));
      for i = 1:scaled_height
          for j= 1:scaled_width
              if((round(i*scale_factor)<height) && (round(j*scale_factor) <width))
                final_image(i,j,:) = input_img(round(i*scale_factor),round(j*scale_factor),:);
              elseif ((round(i*scale_factor)<height))
                final_image(i,j,:) = final_image(i,j-1,:);
              else 
                final_image(i,j,:) =  final_image(i-1,j,:);
              end
          end
      end
  elseif(operation == "non_uniform_scale")
      scaled_width = round(width/x_scale);
      scaled_height = round(height/y_scale);
      final_img = uint8(zeros(scaled_height,scaled_width,3));
      for i = 1:scaled_height
          for j= 1:scaled_width
              if((round(i*y_scale)<height) && (round(j*x_scale) <width))
                final_image(i,j,:) = input_img(round(i*y_scale),round(j*x_scale),:);
              elseif ((round(i*y_scale)<height))
                final_image(i,j,:) = final_image(i,j-1,:);
              else 
                final_image(i,j,:) =  final_image(i-1,j,:);
              end
          end
      end
  end
  figure ;
  imshow(final_image);
  hold on;
end