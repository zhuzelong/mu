function [f1,f2,f3,f4,f5] = lab_features (img) 
% [f1,f2,f3,f4,f5] = lab_features(img)
%
% -- Purpose: Extracts feature vectors 'fx' from an image. This function is
%             called by lab_featuresets, which combines the features
%             into a single vector and normalises it. This vector
%             can then be used for training and testing.
%
% -- <img> a matrix representing the RGB values of the image
% -- <f1>-<f5> features extracted from image
%
% See http://www.generation5.org/content/2004/aisompic.asp for a tutorial
% on a similar technique.
%

    %
    % This function extracts five types of feature from the image
    % You should select which you want to use (see end of function)
    % 
    % RGB Histogram: Divides the RGB colour space up into 
    %                buckets e.g. red (255,0,0), green (0,255,0)
    %                and yellow (255,255,0). The image is iterated
    %                and each pixel's proximity to each bucket
    %                is measured. If for example the pixel is 
    %                very red, then the red bucket has its count
    %                incremented. Essentially this provides a 
    %                histogram detailing the colour of the image.
    %                The feature vector consists of the bucket
    %                counts.
    %
    % RGB Area: Divides the image up into a grid e.g. 3x3. The 
    %           average colour of each grid cell is measured
    %           and used as part of the feature vector. This
    %           can be calculated by simply downsampling (shrinking)
    %           the image.
    %
    % Greyscale Histogram: Like RGB Histogram, but the image is
    %                      converted to greyscale first.
    %
    % Greyscale Area: Like RGB area, but the image is converted to
    %                 greyscale first.
    %
    % Texture: Measures the 'texture' of the image i.e. how much
    %          on average each pixel differs from the rest
    %          of the image.
    %
    
    % TODO: Modify these parameters to your liking
    IMAGE_DOWNSAMPLE_WIDTH = 50;            % Width to downsample the image to when calculating histograms
    IMAGE_DOWNSAMPLE_HEIGHT = 50;           % As above, but height
    GREYSCALE_HISTOGRAM_BUCKET_SIZE = 16;   % Number of buckets to use for greyscale histogram i.e. divides up the space 1-255
    GREYSCALE_AREA_GRID_W = 3;              % Width of grid to use for Greyscale Area
    GREYSCALE_AREA_GRID_H = 3;              % As above but height
    RGB_AREA_GRID_W = 4;                    % Width of grid to use for RGB area
    RGB_AREA_GRID_H = 4;                    % As above but height
    
    f1=[];
    f2=[];
    f3=[];
    f4=[];
    f5=[];

    imgDownSampled = lab_downsample(img, IMAGE_DOWNSAMPLE_WIDTH, IMAGE_DOWNSAMPLE_HEIGHT);
    imgDownSampledGrey=lab_rgb2gray(imgDownSampled);
    
    %
    % RGB Histogram 
    %
  
    % TODO
    % =============================================
    % My code
    % =============================================
    red = [255, 0, 0];
    green = [0, 255, 0];
    blue = [0, 0, 255];
    yellow = [255, 255, 0];
    black = [0, 0, 0];
    white = [255, 255, 255];
    redcount = 0;
    greencount = 0;
    bluecount = 0;
    yellowcount = 0;
    blackcount = 0;
    whitecount = 0;
    rgbbucket = [redcount, greencount, bluecount, yellowcount, blackcount, whitecount];
    
    for i = 1: size(imgDownSampled, 1)
        for j = 1: size(imgDownSampled, 2)
            pixel = imgDownSampled(i, j);
            rdist= pixel * red';
            gdist= pixel * green';
            bdist= pixel * blue';
            ydist = pixel * yellow';
            bkdist = pixel * black';
            wdist = pixel * white';
            
            [junk index] = min([rdist gdist bdist ydist bkdist wdist]);
            rgbbucket(1, index) = rgbbucket(1, index) + 1;
        end % for
    end % for
        



    %
    % RGB Area
    %
    
    % TODO
    % =========================================
    % My code
    % =========================================
    % Break image (50*50) down to grids (4*4)
    imgcell = mat2cell(imgDownSampled, [12 12 12 14], [12 12 12 14], [3]);
    rgb_area_feature = [];
    
    % Find out average color of each grid
    for i = 1: RGB_AREA_GRID_W
        for j = 1: RGB_AREA_GRID_H
        rgb_area_feature = [rgb_area_feature mean(mean(mean(imgcell{i, j})))];
        end % for
    end % for


    %
    % Greyscale Histogram
    %
    
    % Build buckets
    bh = GREYSCALE_HISTOGRAM_BUCKET_SIZE;
    bl = 0;
    gshBuckets = [];
    while (bl < 255)
        gshBuckets = [gshBuckets; [bl, bh]];
        bl = bh;
        bh = bh + GREYSCALE_HISTOGRAM_BUCKET_SIZE;
    end
    
    % Place each pixel in a bucket
    fHistogramGrey=zeros(1, size(gshBuckets, 1));
    for y=1:size(imgDownSampledGrey,1)
        for x=1:size(imgDownSampledGrey,2)
            pixel = imgDownSampledGrey(y, x);
            for bucketIndex=1:size(gshBuckets,1)   
                if (pixel >= gshBuckets(bucketIndex, 1) && pixel < gshBuckets(bucketIndex, 2)) 
                    fHistogramGrey(bucketIndex) = fHistogramGrey(bucketIndex) + 1;
                    break;
                end
            end        
        end
    end
    
    %
    % Greyscale Area
    %
    imgAreaGrey = lab_downsample(imgDownSampledGrey, GREYSCALE_AREA_GRID_W, GREYSCALE_AREA_GRID_H);
    fAreaGrey = [];
    for y=1:size(imgAreaGrey, 1)
        for x=1:size(imgAreaGrey, 2)
            fAreaGrey = [fAreaGrey, imgAreaGrey(y,x,1)]; 
        end
    end
  
    %
    % Texture 
    %
    texture = 0;
    avgPixelGrey = mean(mean(imgDownSampledGrey));
    avgPixelGreyMat = repmat(avgPixelGrey, IMAGE_DOWNSAMPLE_WIDTH, IMAGE_DOWNSAMPLE_HEIGHT);
    fTexture = mean(mean(avgPixelGreyMat - imgDownSampledGrey)); 

    %
    % Return features
    %
               
    f1 = fAreaGrey;
    f2 = fTexture;
    f3 = fHistogramGrey;
    % my RGB bucket
    f4 = rgbbucket;
    f5 = rgb_area_feature;
    
