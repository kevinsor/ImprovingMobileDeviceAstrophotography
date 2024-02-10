function [ I_hdr ] = hdrFusion_func( I,I_long )
%Uses weights on Contrast, Saturation, and Well-Exposedness to combine the
%original merged image with the light enhanced image to directly form an
%LDR image suitable for displays, skipping the intemediate HDR image.

rows = size(I,1);
cols = size(I,2);


%Exposure Fusion
%Imgs = cat(4,I,I_long,I_short);
Imgs = cat(4,I,I_long);
nfiles = 2; %number of images
C = zeros(rows,cols,nfiles);
S = zeros(rows,cols,nfiles);
E = ones(rows,cols,nfiles);
W = zeros(rows,cols,nfiles);
sigma = 0.2;
wc = 2;
ws = 1;
we = 1.5;
for k=1:nfiles
    Ik= Imgs(:,:,:,k);
    %Contrast
    Igray = rgb2gray(Ik);
    h = fspecial('laplacian');
    C(:,:,k) = abs(imfilter(Igray,h,'replicate')+eps);
    %figure; imshow(C(:,:,k));

    %Saturation
    S(:,:,k) = std(Ik,1,3)+eps;
    %figure; imshow(S(:,:,k));
    %Exposure
    for c = 1:3
        E(:,:,k) = E(:,:,k).*exp(-(Ik(:,:,c)-0.5).^2./(2*sigma^2));
    end
   
    W(:,:,k) = C(:,:,k).^(wc).*S(:,:,k).^(ws).*E(:,:,k).^(we);
    
end


weights = zeros(rows,cols,3,nfiles);
for k=1:nfiles
    for c=1:3
        weights(:,:,c,k) = W(:,:,k)./sum(W,3);
    end
    %figure; imshow(weights(:,:,:,k));
end

I_ref = I;
% Create Gaussian pyramid
levels = [1 2 4 8 16];
gaussImPyramids = zeros(rows,cols,3,nfiles,length(levels));
gaussWeightPyramids = zeros(rows,cols,3,nfiles,length(levels));
laplacePyramid = zeros(rows,cols,3,nfiles,length(levels));
gaussImPyramids(:,:,:,:,1) = Imgs;
gaussWeightPyramids(:,:,:,:,1) = weights;
pyrSize = [rows,cols];
% Create Gaussian pyramids
for L = 2:length(levels)
    padAmt = [rows,cols] - ceil(pyrSize./2);
    for k = 1:nfiles
        downsample = impyramid(gaussImPyramids(1:pyrSize(1),1:pyrSize(2),:,k,L-1),'reduce');
        %figure; imshow(downsample);
        
        gaussImPyramids(:,:,:,k,L) = padarray(downsample,[padAmt(1) padAmt(2) 0], 'post');
        gaussWeightPyramids(:,:,:,k,L) = padarray(impyramid(gaussWeightPyramids(1:pyrSize(1),1:pyrSize(2),:,k,L-1),'reduce'),[padAmt(1) padAmt(2) 0], 'post');
        %figure; imshow(gaussWeightPyramids(:,:,:,k,L));
        
    end 
    pyrSize = ceil(pyrSize./2);
end

% Create Laplacian pyramid from Gaussian pyramids
for L = 1:length(levels)-1
    for k = 1:nfiles
        upsample = imresize(gaussImPyramids(:,:,:,k,L+1),2);
        laplacePyramid(:,:,:,k,L) = gaussImPyramids(:,:,:,k,L) - upsample(1:rows,1:cols,:);
        
    end
end

% Multiply by weights and combine 4 Laplacian pyramid files into 1 for
% original reconstruction image (you might not need this depending on how
% many images you're making a pyramid out of - I had a separate pyramid for
% each burst image)
laplace_combined = sum(laplacePyramid.*gaussWeightPyramids,4);
currIm = sum(gaussImPyramids(:,:,:,:,length(levels)).*gaussWeightPyramids(:,:,:,:,L),4);

% Reconstruct
for L = length(levels)-1:-1:1
    upsample = imresize(currIm,2);
    %upSize = size(laplace_combined(:,:,:,:,L));
    currIm = upsample(1:rows,1:cols,:) + laplace_combined(:,:,:,:,L);
end

I_hdr = currIm;
figure;
imshow(I_hdr)
title('HDR fusion image')

end

