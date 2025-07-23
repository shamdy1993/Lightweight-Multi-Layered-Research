function decryptedMessage = hillCipherDecryption(encryptedMessage, keyMatrix)
    encryptedMessage=[62     5   246   135   223    13   201    83   155   186   250    67   139    61   102];
    keyMatrix=[73 24 98; 37 41 162; 0 114 199];
    % Check if the keyMatrix is square
    [rows, cols] = size(keyMatrix);
    if rows ~= cols
        error('Key matrix must be square.');
    end

    if isempty(keyMatrix)
        error('The key matrix is not invertible modulo 256.');
    end

    % Convert encrypted message to ASCII values
    asciiValues = double(encryptedMessage);
    
    % Initialize the decrypted message
    decryptedValues = [];

    % Loop through the ciphertext in pairs
    for i = 1:3:length(asciiValues)
        % Create a pair of characters
        pair = asciiValues(i:i+2);
        
        % Reshape the pair into a column vector
        pairMatrix = reshape(pair, [], 1);
        
        % Decrypt the pair using the inverse key matrix
        decryptedPair = mod(keyMatrix * pairMatrix, 256);
        
        % Append the decrypted values to the result
        decryptedValues = [decryptedValues; decryptedPair];
    end
    
    % Convert back to characters
    decryptedMessage = char(decryptedValues');
    
    % Remove padding spaces (ASCII 32)
    decryptedMessage = strtrim(decryptedMessage);
    
    % Display the decrypted message
    disp('Decrypted Message:');
    disp(decryptedMessage);
end
