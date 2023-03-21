clc

clear

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
disp("Ejemplo 1")
A = [2  1  1  0; 4  3  3  1; 8  7  9  5; 6  7  9  8];
[P, L, U] = gausLU(A)
disp(U);
disp(L);
disp(P);

/*
gausLU(A) =

U =
   8.   7.     9.          5.       
   0.   1.75   2.25        4.25     
   0.   0.    -0.8571429  -0.2857143
   0.   0.     0.          0.6666667

L =
   1.     0.          0.          0.
   0.75   1.          0.          0.
   0.5   -0.2857143   1.          0.
   0.25  -0.4285714   0.3333333   1.

P =
   0.   0.   1.   0.
   0.   0.   0.   1.
   0.   1.   0.   0.
   1.   0.   0.   0.
   
   Efectivamente P*A = L*U

*/

disp("Ejemplo 2")
A = [1 2 0 0; 1 2 1 0;0 5 8 3;0 0 4 11]
[P, L, U] = gausLU(A)
disp(U);
disp(L);
disp(P);

/*
gausLU(A) =

U =
   1.   2.   0.   0.  
   0.   5.   8.   3.  
   0.   0.   4.   11. 
   0.   0.   0.  -2.75

L =
   1.   0.   0.     0.
   0.   1.   0.     0.
   0.   0.   1.     0.
   1.   0.   0.25   1.
P =
   1.   0.   0.   0.
   0.   0.   1.   0.
   0.   0.   0.   1.
   0.   1.   0.   0.
   
   Efectivamente P*A = L*U

*/

disp("Ejemplo 3")
A = [1 5 0; -1 2 1;4 5 8]
[P, L, U] = gausLU(A)
disp(U);
disp(L);
disp(P);

disp(P*A)
disp(L*U)
/*
gausLU(A) =

U =
   4.   5.     8.       
   0.   3.75  -2.       
   0.   0.     4.7333333

L =
   1.     0.          0.
   0.25   1.          0.
  -0.25   0.8666667   1.
P =
   0.   0.   1.
   1.   0.   0.
   0.   1.   0.
   
   Efectivamente P*A = L*U
   
P*A =
   4.   5.   8.
   1.   5.   0.
  -1.   2.   1.
  
L*U =
   4.   5.   8.
   1.   5.   0.
  -1.   2.   1.

*/


// Ejercicio 8

disp("Ejericicio a")
// a)

A = [1.012 -2.132 3.104; -2.132 4.096 -7.013;3.104 -7.013 0.014]
[P, L, U] = gausLU(A)
disp(U);
disp(L);
disp(P);
disp(P*A)
disp(L*U)

/*
gausLU(A) =

U =
   3.104  -7.013       0.014    
   0.     -0.7209188  -7.003384 
   0.      0.          1.5989796
   
L =
   1.          0.          0.
  -0.6868557   1.          0.
   0.3260309  -0.2142473   1.

P =
   0.   0.   1.
   0.   1.   0.
   1.   0.   0.

P*A =
   3.104  -7.013   0.014
  -2.132   4.096  -7.013
   1.012  -2.132   3.104

L*U =
   3.104  -7.013   0.014
  -2.132   4.096  -7.013
   1.012  -2.132   3.104
*/

disp("Ejericicio b")
// b)

A = [2.1756 4.0231 -2.1732 5.1967;-4.0231 6.0000 0 1.1973;-1.0000 5.2107 1.1111 0;6.0235 7.0000 0 4.1561]

[P, L, U] = gausLU(A)
disp(U);
disp(L);
disp(P);
disp(P*A)
disp(L*U)

/*
gausLU(A) =

U =
   6.0235   7.          0.       4.1561   
   0.       10.675305   0.       3.9731622
   0.       0.         -2.1732   3.1392381
   0.       0.          0.      -0.0768597
   
L =
   1.          0.          0.          0.
  -0.6679007   1.          0.          0.
   0.3611854   0.1400243   1.          0.
  -0.1660164   0.596968   -0.5112737   1.

P =
   0.   0.   0.   1.
   0.   1.   0.   0.
   1.   0.   0.   0.
   0.   0.   1.   0.

P*A =
   6.0235   7.       0.       4.1561
  -4.0231   6.       0.       1.1973
   2.1756   4.0231  -2.1732   5.1967
  -1.       5.2107   1.1111   0.  
  
L*U =
   6.0235   7.       0.       4.1561
  -4.0231   6.       0.       1.1973
   2.1756   4.0231  -2.1732   5.1967
  -1.       5.2107   1.1111   0.   
*/


