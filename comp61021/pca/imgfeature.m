function dimgs = imgfeature(imgdir, maxSamples)
% Read images into Matlab.

down_width = 50;
down_height = 50;

imgs = dir(imgdir);
    if (size(imgs, 1) == 0)
        fprintf(2, 'No images found.\n');
        imgs=[];
        features=[];
        return;
    end
    
    fprintf(2, 'Extracting features...\n');    
   
    toRemove = [];
    
    % Remove non-JPGs
    for i=1:size(imgs,1)
        isjpg=findstr(imgs(i).name, '.jpg');
        if (size(imgs(i).name, 2) < 4 || size(isjpg,1) == 0)
            isjpg=findstr(imgs(i).name, '.JPG');
            if (size(imgs(i).name, 2) < 4 || size(isjpg,1) == 0)
                fprintf(2, 'Ignoring %s as it is not a JPG\n', imgs(i).name);
                toRemove = [toRemove, i]; 
            end
        end
    end
   
    imgs(toRemove) = [];
    
    if (maxSamples < 0)
        maxSamples = size(imgs,1);
    end
    
    for i=1:maxSamples   
        imgs(i).name=sprintf('%s%s', imgdir,imgs(i).name);
        img = imread(imgs(i).name);
        dimg = lab_downsample(img, down_width, down_height);
        dimg = reshape(dimg, 1, down_width*down_height*3);
        dimgs(i,:) = dimg;
    end

end
