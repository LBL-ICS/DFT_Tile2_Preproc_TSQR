% Step 1: Generate random input matrix (256x128) between -3 and 3
rows=4;
cols=2;
A = single(rand(rows, cols) * 2 - 1);
%A = single([1.0, -1.0; 1.0, 1.0; 1.0, 1.0; 1.0, 2.0]);
A

% Step 2: Store the entire matrix in dmx_real.txt in column major order
Trans_A = transpose(A)
dlmwrite('dmx_real.txt', Trans_A);

% Step 3: Store the entire matrix in dmx_ieee754.txt in column major order
dmx_ieee754 = fopen('dmx_ieee754.txt', 'w');
dmx_ieee_754_word = fopen('dmx_ieee754_word.txt', 'w');
for i = 1:cols
    column_data = A(:, i);
    for j = 1:numel(column_data)
        hex_value = dec2hex(typecast(column_data(j), 'uint32'));
        if j==numel(column_data)
            if hex_value=='0'
                fprintf(dmx_ieee754, '00000000\n');
            else
                fprintf(dmx_ieee754, '%s\n', hex_value);
            end
        else
            if hex_value=='0'
                fprintf(dmx_ieee754, '00000000');
            else
                fprintf(dmx_ieee754, '%s', hex_value);
            end
        end

        if hex_value=='0'
            fprint(dmx_ieee_754_word,'00000000\n');
        else
            fprintf(dmx_ieee_754_word, '%s\n', hex_value);
        end
        
    end
end
fclose(dmx_ieee754);
fclose(dmx_ieee_754_word);

% Step 4: Perform TSQR computation on input matrix A
[Q, R] = qr(A, 0);

% Step 5: Store the output 128x128 matrix in tri_real.txt in column major order
SR=single(R)
Trans_SR = transpose(SR)
dlmwrite('tri_real.txt', Trans_SR);

% Step 6: Store the output 128x128 matrix in tri_ieee754.txt in column major order
tri_ieee754 = fopen('tri_ieee754.txt', 'w');
for i = 1:cols
    column_data = SR(:, i);
    for j = 1:numel(column_data)
        hex_value = dec2hex(typecast(column_data(j), 'uint32'));
        if j==numel(column_data)
            if hex_value=='0'
                fprintf(tri_ieee754, '00000000\n');
            else
                fprintf(tri_ieee754, '%s\n', hex_value);
            end
        else
            if hex_value=='0'
                fprintf(tri_ieee754, '00000000');
            else
                fprintf(tri_ieee754, '%s', hex_value);
            end
        end
    end
end
fclose(tri_ieee754);
