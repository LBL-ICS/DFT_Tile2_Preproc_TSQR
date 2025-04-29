

function C = random_complex_matrix()
    m = 2; % cols
    n = 6; % rows
    real_part = randn(n,m); 
    imag_part = randn(n,m);  
    C = real_part + 1i * imag_part;
end

B = random_complex_matrix();




function tsqr = TSQR_gen(A)
[n, m] = size(A);

for k = 1:m
    % extarct xk 
    xk = A(k:end, k);
    
    % hh vk computation
    d1 = dot(xk, xk);
    d2 = sqrt(d1);
    vk = xk;
    vk(1) = xk(1) + sign(xk(1)) * d2;
    
    % normalization of vk
    d3 = dot(vk, vk);
    tau_k = -2 / d3;
    
    % update all columns 
    for j = k:m
        yj = A(k:end, j); % extract jth column
        d4 = dot(yj, vk); % update by yj * vk 
        d5 = tau_k * d4; % 
        yj = yj + d5 * vk;  % apply hh reflection
        
        % write yj back to A
        A(k:end, j) = yj;
    end
end

% Return modified A matrix (upper triangular R)
tsqr = A;
end










R=B;
R = TSQR_gen(R);


function  write_hex(A,R)

[rows, cols] = size(A);

dmx = fopen('golden\dmx.txt', 'w');
tri = fopen('golden\tri.txt', 'w');
dmx_ieee754 = fopen('golden\dmx_ieee754.txt', 'w');
tri_ieee754 = fopen('golden\tri_ieee754.txt', 'w');


for j = 1:size(A,2)  
    for i = 1:size(A,1)  
        fprintf(dmx,'%f %fi ', real(A(i,j)), imag(A(i,j))); 
    end
    fprintf(dmx,'\n'); 
end
fclose(dmx);

for j = 1:size(R,2)  
    for i = 1:size(R,1)  
        fprintf(tri,'%f %fi ', real(R(i,j)), imag(R(i,j)));
    end
    fprintf(tri,'\n'); 
end
fclose(tri);



for col = 1:cols
    row_hex = ''; 
    R_row_hex = ''; 

    for row = 1:rows
        real_part = real(A(row, col)); 
        imag_part = imag(A(row, col)); 
        R_real_part = real(R(row, col));
        R_imag_part = imag(R(row, col)); 
        real_hex = dec2hex(typecast(single(real_part), 'uint32'), 8);
        imag_hex = dec2hex(typecast(single(imag_part), 'uint32'), 8);
        R_real_hex = dec2hex(typecast(single(R_real_part), 'uint32'), 8);
        R_imag_hex = dec2hex(typecast(single(R_imag_part), 'uint32'), 8);

        row_hex = [row_hex, real_hex, imag_hex]; 
        R_row_hex = [R_row_hex, R_real_hex, R_imag_hex]; 
    end

    fprintf(dmx_ieee754, '%s\n', row_hex);
    fprintf(tri_ieee754, '%s\n', R_row_hex);

end

fclose(dmx_ieee754);
fclose(tri_ieee754);

end

 write_hex(B,R);


 disp(B);
 disp(R);

 %%
% matlab's qr function
% returns different results 
 [a,r]= qr(B);
 disp(r);