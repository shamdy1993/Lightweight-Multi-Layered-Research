function encryptedMessage = hillCipherEncryption(secretMessage, keyMatrix)
    secretMessage='Sara Hamdy';
    keyMatrix=[11 4; 2 1];
    % Check if the keyMatrix is square
    [rows, cols] = size(keyMatrix);
    if rows ~= cols
        error('Key matrix must be square.');
    end

    % Convert secret message to ASCII values
    asciiValues = double(secretMessage);
    
    % Calculate the length of the message
    messageLength = length(asciiValues);
    keySize = rows;

    % Pad the message with spaces (ASCII 32) if necessary
    if mod(messageLength, keySize) ~= 0
        paddingLength = keySize - mod(messageLength, keySize);
        asciiValues = [asciiValues, repmat(32, 1, paddingLength)]; % Pad with spaces
    end
    
    % Initialize the encrypted message
    encryptedValues = [];

    % Loop through the plaintext in pairs
    for i = 1:2:messageLength
        if i + 1 <= messageLength
            % Create a pair of characters
            pair = asciiValues(i:i+1);
        else
            % If there's an odd character out, use padding
            pair = [asciiValues(i), 32]; % Pad with space
        end
        
        % Reshape the pair into a column vector
        pairMatrix = reshape(pair, [], 1);
        
        % Encrypt the pair using the Hill Cipher
        encryptedPair = mod(keyMatrix * pairMatrix, 256);
        
        % Append the encrypted values to the result
        encryptedValues = [encryptedValues; encryptedPair];
    end
    encryptedValues=reshape(encryptedValues,1,[]);
    disp(encryptedValues);
    % Convert back to characters
    encryptedMessage = char(encryptedValues');
    encryptedMessage=reshape(encryptedMessage,1,[]);
    
    % Display the ciphertext in the original order
    disp('Encrypted Message in Original Order:');
    disp(encryptedMessage);
end