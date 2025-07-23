function encrypted_message = EncryptionPhase(secret_message, PK, block_length)
    % Get the inputs
   block_length=10;
    
    % Resize image_key to get PK
    PK = [95    82    77   125    97    97   110   122   178   181];
    secret_message='jEß/0A';
 % Divide the secret message into N blocks
message_blocks = mat2cell(secret_message, 1, 10*ones(1, floor(numel(secret_message)/10)));
    
    encrypted_message = ''; 
    tic;
    for i = 1:numel(message_blocks)

        % Calculate RLD (RLD=L+PK(I)+1)
        RLD = (block_length/2)*4 + PK(i) + 1;
 
        % Convert the message block to decimal
        decimal_block = double(message_blocks{i});
        
        % Convert the decimal block to binary
        binary_block = dec2bin(decimal_block, 8);
        
        % Reshape the binary version into one row matrix
        binary_matrix = reshape(binary_block', 1, []);
        
        % Rotate the row matrix to the left RLD times
        rotated_matrix = circshift(binary_matrix, RLD);
        
        % Reshape back to 8 columns matrix
        encrypted_block = reshape(rotated_matrix, 8, []);
        
        
        % Convert the resulting matrix to decimal
        encrypted_decimal = bin2dec(encrypted_block');
        encrypted_decimal=reshape(encrypted_decimal,1,[]);
        disp(encrypted_decimal);
        
        % Pad to the encrypted message
        encrypted_message = [encrypted_message, char(encrypted_decimal)];
        elapsed_time=toc;
    end
        disp(block_length);
        disp(RLD);
     encrypted_message=reshape(encrypted_message,1,[]);
     disp(encrypted_message);
     fprintf('Elapsed time for section 2: %.6f seconds\n', elapsed_time);
end


