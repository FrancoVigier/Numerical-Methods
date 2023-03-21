clc
clear
/*
    El algoritmo es similar a eliminacion de gauss pero al final no se
    realiza sustitucion regresiva sino multiplicar los elementos de la
    diagonal y de esa forma obtener el determinante de la matriz.
*/
function [s1, s2] = gaussDeterminante(A)
    a = size(A)
    n = a(1)
    for k=1:(n-1)
        for j = (k+1):n
            mjk = A(j,k)/A(k,k)
            A(j, k) = 0
            // Elimino el for que recorre la fila entera
            // y utilizo la notacion de scilab para hacerlo.
            A(j, k+1:n) = A(j, k+1:n) - mjk * A(k, 1+k:n)
        end
    end
    s1 = A
    s2 = 1
    
    // Se multiplican los elementos de la diagonal.
    for i=1:n
        s2 = s2 * A(i,i)
    end
    
endfunction

A = [1 2 3; 3 -2 1; 4 2 -1]
[D, dete] = gaussDeterminante(A)
disp(D, dete)

// Det(A) = 56

A = [1 2 3; 1 -2 3; 4 2 -1]
[D, dete] = gaussDeterminante(A)
disp(D, dete)

// Det(A) = 52

A = [7 8 9; 1 -2 3; 4 2 -1]
[D, dete] = gaussDeterminante(A)
disp(D, dete)

// Det(A) = 166
