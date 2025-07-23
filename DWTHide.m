function hideTextInColorImage(imageFile, textToHide)
    % Read the color image
    imageFile="num60.png";
    img = imread(imageFile);
    
    % Ensure textToHide is exactly 10 characters long
    textToHide=[141   242   243     4    17    80   118   164    88     8];
    assert(length(textToHide) == 10, 'Text must be exactly 10 characters long.');
    % Convert text to binary
   
    binaryText = textToBinary(textToHide);
    % Get the length of the message and convert to binary
    messageLength = dec2bin(length(binaryText), 16); % 16 bits for length
    binaryText = [messageLength binaryText]; % Prepend length
    disp (binaryText);
    
    % Split the image into RGB channels
    redChannel = img(:,:,1);
    greenChannel = img(:,:,2);
    blueChannel = img(:,:,3);
    
    % Apply DWT to each channel
    [C_red, S_red] = wavedec2(redChannel, 1, 'haar');
    [C_green, S_green] = wavedec2(greenChannel, 1, 'haar');
    [C_blue, S_blue] = wavedec2(blueChannel, 1, 'haar');
    
    % Embed binary text into the wavelet coefficients of each channel
    C_red = embedTextInCoefficients(C_red, binaryText);
    C_green = embedTextInCoefficients(C_green, binaryText);
    C_blue = embedTextInCoefficients(C_blue, binaryText);
    
    % Reconstruct the modified channels
    modifiedRedChannel = uint8(waverec2(C_red, S_red, 'haar'));
    modifiedGreenChannel = uint8(waverec2(C_green, S_green, 'haar'));
    modifiedBlueChannel = uint8(waverec2(C_blue, S_blue, 'haar'));
    
    % Combine the modified channels back into a single color image
    modifiedImg = cat(3, modifiedRedChannel, modifiedGreenChannel, modifiedBlueChannel);
    
    % Save the modified image
    outputImageFile='DWT modified.png';
    imwrite(modifiedImg, outputImageFile);
    disp('Text hidden in the color image successfully!');
end

function binaryText = textToBinary(text)
    % Convert text to binary
    binaryText = '';
    for i = 1:length(text)
        binaryChar = dec2bin(text(i), 8); % 8 bits for each character
        binaryText = [binaryText binaryChar];
    end
end

function C = embedTextInCoefficients(C, binaryText)
    % Embed the binary text into the coefficients
    C = round(C); % Ensure coefficients are integers
    C = uint32(C); % Change to uint32 or appropriate type
    
    for i = 1:length(binaryText)
        if i <= length(C)
            C(i) = bitset(C(i), 1, str2double(binaryText(i))); % Modify LSB
        end
    end
end