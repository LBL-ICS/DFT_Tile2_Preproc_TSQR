
%% randomly generated matrix function
function C = random_complex_matrix(n,m) % n is rows, m is cols
   
    real_part = randn(n,m); 
    imag_part = randn(n,m);  
    C = real_part + 1i * imag_part;
end

function F = random_energy(m) % m is cols
   
    val = randn(1,m);
    F = val;
end

%% pre-processor golden 


%preset for testing purposes
% to generate random pg, ug and energy values, replace col and rows
% with desired size then uncomment the following:
pg = random_complex_matrix(512,256);
ug = random_complex_matrix(512,256);
e_pg = random_energy(256);
e_ug = random_energy(256);
e_upg = random_energy(256);


%%

%%


[rows, cols] = size(ug);
for i = 1:cols
theta = ( 0.5* atan((2 * e_upg(i)) / (e_ug(i) - e_pg(i))));
c = cos(theta);
s = sin(theta);
new_ug(:,i) = ((ug(:,i)) * cos(theta)) + ((pg(:,i)) * sin(theta));
end
%%

function  write_hex_pp(ug,pg,new_ug, e_pg,e_upg,e_ug)


[rows, cols] = size(ug);
fug = fopen('golden\ug.txt', 'w');
fpg = fopen('golden\pg.txt', 'w');
fnew_ug = fopen('golden\new_ug.txt', 'w');
ug_ieee754 = fopen('golden\ug_ieee754.txt', 'w');
pg_ieee754 = fopen('golden\pg_ieee754.txt', 'w');
new_ug_ieee754 = fopen('golden\new_ug_ieee754.txt', 'w');
fe_upg = fopen('golden\e_upg.txt', 'w');
fe_pg = fopen('golden\e_pg.txt', 'w');
fe_ug = fopen('golden\e_ug.txt', 'w');
fe_upg_ieee = fopen('golden\e_upg_ieee754.txt', 'w');
fe_pg_ieee = fopen('golden\e_pg_ieee754.txt', 'w');
fe_ug_ieee = fopen('golden\e_ug_ieee754.txt', 'w');



for j = 1:size(ug,2)  
    for i = 1:size(ug,1)  
        fprintf(fug,'%f %fi ', real(ug(i,j)), imag(ug(i,j))); 
    end
    fprintf(fug,'\n'); 
end
fclose(fug);

for j = 1:size(pg,2)  
    for i = 1:size(pg,1)  
        fprintf(fpg,'%f %fi ', real(pg(i,j)), imag(pg(i,j)));
    end
    fprintf(fpg,'\n'); 
end
fclose(fpg);

for j = 1:size(new_ug,2)  
    for i = 1:size(new_ug,1)  
        fprintf(fnew_ug,'%f %fi ', real(new_ug(i,j)), imag(new_ug(i,j)));
    end
    fprintf(fnew_ug,'\n'); 
end
fclose(fnew_ug);



    for i = 1:cols  
        fprintf(fe_pg,'%f ', e_pg(i) );
        fprintf(fe_pg,'\n');
        fprintf(fe_pg_ieee, '%s\n', dec2hex(typecast(single(e_pg(i)), 'uint32'), 8));
    end
fclose(fe_pg);

   for i = 1:cols  
        fprintf(fe_ug,'%f ', e_ug(i) );
        fprintf(fe_ug,'\n');
        fprintf(fe_ug_ieee, '%s\n', dec2hex(typecast(single(e_ug(i)), 'uint32'), 8));

    end
     
fclose(fe_ug);


   for i = 1:cols  
        fprintf(fe_upg,'%f ', e_upg(i) );
        fprintf(fe_upg,'\n');
        fprintf(fe_upg_ieee, '%s\n', dec2hex(typecast(single(e_upg(i)), 'uint32'), 8));
    end
     
fclose(fe_upg);

for col = 1:cols
    ug_row_hex = ''; 
    pg_row_hex = ''; 
    new_ug_row_hex = ''; 
    
    for row = 1:rows
        ug_real_part = real(ug(row, col)); 
        ug_imag_part = imag(ug(row, col)); 
        pg_real_part = real(pg(row, col)); 
        pg_imag_part = imag(pg(row, col)); 
        new_ug_real_part = real(new_ug(row, col)); 
        new_ug_imag_part = imag(new_ug(row, col)); 
        
        ug_real_hex = dec2hex(typecast(single(ug_real_part), 'uint32'), 8);
        ug_imag_hex = dec2hex(typecast(single(ug_imag_part), 'uint32'), 8);
        pg_real_hex = dec2hex(typecast(single(pg_real_part), 'uint32'), 8);
        pg_imag_hex = dec2hex(typecast(single(pg_imag_part), 'uint32'), 8);
        new_ug_real_hex = dec2hex(typecast(single(new_ug_real_part), 'uint32'), 8);
        new_ug_imag_hex = dec2hex(typecast(single(new_ug_imag_part), 'uint32'), 8);

        ug_row_hex = [ug_row_hex, ug_real_hex, ug_imag_hex]; 
        pg_row_hex = [pg_row_hex, pg_real_hex, pg_imag_hex];
        new_ug_row_hex = [new_ug_row_hex, new_ug_real_hex, new_ug_imag_hex];
    end

    fprintf(ug_ieee754, '%s\n', ug_row_hex);
    fprintf(pg_ieee754, '%s\n', pg_row_hex);
    fprintf(new_ug_ieee754, '%s\n', new_ug_row_hex);

end

fclose(ug_ieee754);
fclose(pg_ieee754);
fclose(new_ug_ieee754);

end





function tsqr = TSQR_gen(A)
[n, m] = size(A);

for k = 1:m
    % extarct xk 
    xk = A(k:end, k);
    
    % hh vk computation
    d1 = (xk'* xk);
    fprintf('xk_real is: %f and xk_imag is: %f \n', real(xk), imag(xk));
    fprintf('d1_real is: %f and d1_im is: %f \n', real(d1), imag(d1));
    d2 = sqrt(d1);
     fprintf('d2 is: %f\n ', d2);
    vk = xk;
    vk(1) = xk(1) + sign(xk(1)) * d2;
    fprintf('vk_real is: %f and vk_im is: %f \n', real(vk), imag(vk));
    % normalization of vk
    d3 = (vk'* vk);
    fprintf('d3 is: %f\n ', d3);

    tau_k = -2 / d3;
    fprintf('tk is: %f\n ', tau_k);
    % update all columns 
    for j = k:m
        yj = A(k:end, j); % extract jth column
        fprintf('copied yj_real is: %f and yj_imag is: %f \n ', real(yj), imag(yj));
        d4 = (vk' * yj); % update by yj * vk 
         fprintf('d4 is: %f\n ', d4);
        d5 = tau_k * d4; % 
         fprintf('d5 is: %f\n ', d5);
        yj = yj + d5 * vk;  % apply hh reflection
        fprintf('new yj_real is: %f and yj_imag is: %f \n ', real(yj), imag(yj));
        % write yj back to A
        A(k:end, j) = yj;
    end
end

% Return modified A matrix (upper triangular R)
tsqr = A;
end





function  write_hex(R)

[rows, cols] = size(R);

%dmx = fopen('golden\dmx.txt', 'w');
tri = fopen('golden\tri.txt', 'w');
%dmx_ieee754 = fopen('golden\dmx_ieee754.txt', 'w');
tri_ieee754 = fopen('golden\tri_ieee754.txt', 'w');


for j = 1:size(R,2)  
    for i = 1:size(R,1)  
        fprintf(tri,'%f %fi ', real(R(i,j)), imag(R(i,j)));
    end
    fprintf(tri,'\n'); 
end
fclose(tri);



for col = 1:cols
    %row_hex = ''; 
    R_row_hex = ''; 

    for row = 1:rows
        %real_part = real(A(row, col)); 
        %imag_part = imag(A(row, col)); 
        R_real_part = real(R(row, col));
        R_imag_part = imag(R(row, col)); 
        %real_hex = dec2hex(typecast(single(real_part), 'uint32'), 8);
        %imag_hex = dec2hex(typecast(single(imag_part), 'uint32'), 8);
        R_real_hex = dec2hex(typecast(single(R_real_part), 'uint32'), 8);
        R_imag_hex = dec2hex(typecast(single(R_imag_part), 'uint32'), 8);

        %row_hex = [row_hex, real_hex, imag_hex]; 
        R_row_hex = [R_row_hex, R_real_hex, R_imag_hex]; 
    end

    %fprintf(dmx_ieee754, '%s\n', row_hex);
    fprintf(tri_ieee754, '%s\n', R_row_hex);

end

%fclose(dmx_ieee754);
fclose(tri_ieee754);

end

 function s = TSQR_HW(tall_matrix,sw)
[rows, cols] = size(tall_matrix);

r = tall_matrix(1:sw, :);
r = TSQR_gen(r);

tiles = (rows - sw)/(sw/2)+1;

for i=2:tiles
r(((sw/2)+1):sw,:) = tall_matrix((i*(sw/2))+1:sw+((sw/2)*(i-1)),:);
r = TSQR_gen(r);

end

s = r;
 end

%%

 write_hex_pp(ug,pg,new_ug,e_pg, e_upg, e_ug);
 R_matrix = TSQR_HW(new_ug, 512);

 write_hex(R_matrix(1:256, :));
 
 %disp(new_ug);
 %disp(R_matrix);
