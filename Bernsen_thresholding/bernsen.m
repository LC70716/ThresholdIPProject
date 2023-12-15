%BERNSEN local thresholding.
%   BW = BERNSEN(IMAGE) performs local thresholding of a two-dimensional
%   array IMAGE with Bernsen's thresholding. The method uses a 
%   user-provided contrast threshold. If the local contrast (max-min) is 
%   above or equal to the contrast threshold, the threshold is set at the
%   local midgrey value (the mean of the minimum and maximum grey values in
%   the local window). If the local contrast is below the contrast 
%   threshold the neighbourhood is considered to consist only of one class
%   and the pixel is set to object or background depending on the value of 
%   the midgrey. 
%      
%   BW = BERNSEN(IMAGE, [M N], CONTRAST_THRESHOLD, PADDING) performs local
%   thresholding with odd valued M-by-N neighbourhood (default is 3-by-3).
%   The default value for CONTRAST_THRESHOLD is 15. To deal with border 
%   pixels the image is padded with one of PADARRAY options (default is 
%   'replicate').
%
%   The algorithm description is available at:
%       http://fiji.sc/wiki/index.php/Auto_Local_Threshold#Bernsen 
%
%   Examples
%   -------
%       % Threshold MATLAB's grayscale example image 
%       imshow(bernsen(imread('eight.tif')));
%
%       % Threshold the attached jpg image
%       imshow(bernsen(rgb2gray(imread('image.jpg')), [93,93]));
%
%   See also PADARRAY, RGB2GRAY.
%   Contributed by Jan Motl (jan@motl.us)
%   $Revision: 1.1 $  $Date: 2014/10/24 16:38:01 $
function output = bernsen(image, varargin)
% Initialization
numvarargs = length(varargin);      % only want 3 optional inputs at most
if numvarargs > 3
    error('myfuns:somefun2Alt:TooManyInputs', ...
     'Possible BERNSEN parameters are: (image, [m n], contrast, padding)');
end
 
optargs = {[3 3] 15 'replicate'};   % set defaults
 
optargs(1:numvarargs) = varargin;   % use memorable variable names
[window, contrast_threshold, padding] = optargs{:};
if ndims(image) ~= 2
    error('The input image must be a two-dimensional array.');
end
if sum(mod(window,2))~=2
    error('Sorry, only odd valued window dimensions are supported');
end
% Convert to double
image = double(image);
% Mean value
mean = averagefilter(image, window, padding);
% Local contrast
local_contrast = maxfilt2(image, window) - minfilt2(image, window);
% Initialize the output
output = zeros(size(image));
% Whenever contrast in the window is low assume homogenous area
mask = local_contrast < contrast_threshold;
output(mask & image>=128) = 1;
% Otherwise compare to the mean value
output(~mask) = (image(~mask) >= mean(~mask));
