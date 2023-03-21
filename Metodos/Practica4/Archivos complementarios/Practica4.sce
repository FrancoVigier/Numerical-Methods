// Para matriz diagonal, x = b ./diag(A)
// Para matriz triangular xn = bn/xa
// xi = (bi - A(i,i+1:n)x(i+1:n))/aii 
clc
clear
function sol = remonte(A, B)
    n = size(A)(1)
    x(n) = B(n)/A(n,n)
    for i=n-1:-1:1
        x(i) = (B(i) - A(i,i+1:n) * x(i+1:n))/A(i,i) 
    end
    sol = x
endfunction

function [s1, s2] = gauss(A, b)
    a = size(A)
    n = a(1)
    for k=1:(n-1)
        for j = (k+1):n
            mjk = A(j,k)/A(k,k)
            A(j, k) = 0
            A(j, k+1:n) = A(j, k+1:n) - mjk * A(k, 1+k:n)
            b(j) = b(j) - mjk * b(k)
        end
    end
    s1 = A
    s2 = b
endfunction


function [s1, s2] = lu(A)
    a = size(A)
    n = a(1)
    for k=1:(n-1)
        for j = (i+1):n
            mjk = A(j,k)/A(k,k)
            L(j, k) = mjk
            A(j, k) = 0
            A(j, :) = A(j, :) - mjk * A(k, :)
        end
    end
    s1 = A
    s2 = L
endfunction

A = [2 6 4; 9 8 1; 2 5 9]
disp(A)
b = [1; 2; 3]
x=A\b
disp(x)

C = [2 6 4; 9 8 1; 2 5 9]
[F, G] = gauss(C, b);
disp(remonte(F, G));


