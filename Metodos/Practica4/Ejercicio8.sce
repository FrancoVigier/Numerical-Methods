clc

clear


// Ejercicio 9

function [P, L, U] = gausLU(A)
    [nA,m] = size(A) 
    U = A
    L = eye(nA, nA)
    P = eye(nA, nA)
    
    // pivoteo, se verrifica el mayor y se cambia la fila en todas las matrices
    for k = 1:m-1 do
        maxi = -1
        maxval = -1
        for i = k:m do 
            if abs(U(i ,k)) > maxval then
                maxval = abs(U(i ,k))
                maxi = i
            end
        end
        

        // Se pivotea tanto en U como en L como en P
        temp = U(k, k:m)
        U(k, k:m) = U(maxi,k:m)
        U(maxi,k:m) = temp
        
        temp = L(k,1:k-1)
        L(k, 1:k-1) = L(maxi, 1:k-1)
        L(maxi, 1:k-1) = temp
        
        temp = P(k,:)
        P(k,:) = P(maxi, :)
        P(maxi, :) = temp
       
        // Sustitucion regresiva.
        for j = k+1:m do
            L(j,k) = U(j,k)/U(k,k) // Calculo de la inversa de las matrices de eliminacion implicito
            U(j,k:m) = U(j,k:m) - L(j,k) * U(k,k:m) // Operacion entre filas (ver Gauss)
        end
    end
    
endfunction


A = [1.012 -2.132 3.104;
    -2.132 4.096 -7.013;
    3.104 -7.013 0.014]
    
[P L U] = gausLU(A)
disp("Matriz A")
disp("Algoritmo ejercicio 7")
disp(P)
disp(L)
disp(U)

/*
gausLU(A)

P =
   0.   0.   1.
   0.   1.   0.
   1.   0.   0.

L =
   1.          0.          0.
  -0.6868557   1.          0.
   0.3260309  -0.2142473   1.

U =
   3.104  -7.013       0.014    
   0.     -0.7209188  -7.003384 
   0.      0.          1.5989796

Efectivamente P*A=L*U

*/

[L U P] = lu(A)
disp("Funcion de scilab")
disp(P)
disp(L)
disp(U)

/*
lu(A)

P =
   0.   0.   1.
   0.   1.   0.
   1.   0.   0.
L =
   1.          0.          0.
  -0.6868557   1.          0.
   0.3260309  -0.2142473   1.
U =
   3.104  -7.013       0.014    
   0.     -0.7209188  -7.003384 
   0.      0.          1.5989796

*/


B = [2.1756 4.0231 -2.1732 5.1967;
    -4.0231 6.0000 0 1.1973;
    -1.0000 5.2107 1.1111 0;
     6.0235 7.0000 0 4.1561]
    
[P L U] = gausLU(B)
disp("Matriz B")
disp("Algoritmo ejercicio 7")
disp(P)
disp(L)
disp(U)

/*
gausLU(A)

P =
   0.   0.   0.   1.
   0.   1.   0.   0.
   1.   0.   0.   0.
   0.   0.   1.   0.

L =
   1.          0.          0.          0.
  -0.6679007   1.          0.          0.
   0.3611854   0.1400243   1.          0.
  -0.1660164   0.596968   -0.5112737   1.

U =
   6.0235   7.          0.       4.1561   
   0.       10.675305   0.       3.9731622
   0.       0.         -2.1732   3.1392381
   0.       0.          0.      -0.0768597

Efectivamente P*A=L*U

*/

[L U P] = lu(B)
disp("Funcion de scilab")
disp(P)
disp(L)
disp(U)

/*
lu(A)

P =
   0.   0.   0.   1.
   0.   1.   0.   0.
   1.   0.   0.   0.
   0.   0.   1.   0.

L =
   1.          0.          0.          0.
  -0.6679007   1.          0.          0.
   0.3611854   0.1400243   1.          0.
  -0.1660164   0.596968   -0.5112737   1.
  
U =
   6.0235   7.          0.       4.1561   
   0.       10.675305   0.       3.9731622
   0.       0.         -2.1732   3.1392381
   0.       0.          0.      -0.0768597
   
   
   Vemos que ambos resultados son similares.
*/
