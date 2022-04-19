function [output_image, face_detect_bool]=face_detect(input_image)
FDetect = vision.CascadeObjectDetector;
%I=imread(input_image);
I=input_image;
BB = step(FDetect,I);
    [r c]=size(BB);
    if(r==1)
        BBB(:) = BB(:);
        filename='face.jpg';
        I=imcrop(I,[BBB(1,1),BBB(1,2),BBB(1,3),BBB(1,4)]);
        %imshow(I);
        imwrite(I,filename);
        output_image=imread('face.jpg');        
    else
        output_image=imread('no_face_detected.jpg');
    end
face_detect_bool = r;