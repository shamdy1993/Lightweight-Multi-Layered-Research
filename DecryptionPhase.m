function original_message = DecryptionPhase(encrypted_message, L, PK)
    % Get the input4
    L = 10;
    
    % Resize image_key to get PK
    PK = [95    82    77   125    97    97   110   122   178   181];
    encrypted_message=[141   242   243     4    17    80   118   164    88     8];
    % Divide the encrypted message into N blocks
    message_blocks = mat2cell(encrypted_message, 1, 10*ones(1, floor(numel(encrypted_message)/10)));
    
    original_message = '';
    tic;
    for i = 1:numel(message_blocks)
        % Calculate RLD1 (RLD1=L*8-RLD)
        RLD = (L/2)*4 + PK(i)+1;
        RLD1 = L * 8 -RLD  ;
        disp(RLD1);
        
        % Convert the message block to decimal
        decimal_block = double(message_blocks{i});
        
        % Convert the decimal block to binary
        binary_block = dec2bin(decimal_block, 8);
        
        % Reshape the binary version into one row matrix
        binary_matrix = reshape(binary_block', 1, []);
        
        % Rotate the row matrix to the left RLD1 times
        rotated_matrix = circshift(binary_matrix, RLD1);
        
        % Reshape back to 8 columns matrix
        decrypted_block = reshape(rotated_matrix, 8, []);
        
        % Convert the resulting matrix to decimal
        decrypted_decimal = bin2dec(decrypted_block');
        decrypted_decimal=reshape(decrypted_decimal,1,[]);
        disp(decrypted_decimal);
        
        % Append the decrypted block to the original message
        original_message = [original_message, char(decrypted_decimal)];
        original_message =reshape(original_message,1,[]);
        toc;
    end
end


