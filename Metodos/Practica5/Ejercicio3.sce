clc
clear

/* General la matriz especifica del ejercicio

   2.  -1.   0.   0.   0.
  -1.   2.  -1.   0.   0.
   0.  -1.   2.  -1.   0.
   0.   0.  -1.   2.  -1.
   0.   0.   0.  -1.   2.

*/

function A = tridiagonal(n)
    // se genera la diagonal inferior
    diagInf = -1*ones(1,n-1)
    // se genera la diagonal central
    diagCentral = 2*ones(1,n)
    // se unen en la matriz final.
    A = diag(diagInf,-1)+diag(diagCentral)+diag(diagInf,1)
endfunction

/*
   n = 3
   
   2.  -1.   0.
  -1.   2.  -1.
   0.  -1.   2.
   
   n = 5
   
   2.  -1.   0.   0.   0.
  -1.   2.  -1.   0.   0.
   0.  -1.   2.  -1.   0.
   0.   0.  -1.   2.  -1.
   0.   0.   0.  -1.   2.

*/

function matriz = matrizJacobi(A)
    n = size(A)(1)
    I = eye(n,n)
    // Se calcula la matriz de iteracion.
    matriz = I - inv(tril(A))*A
endfunction

disp(matrizJacobi(tridiagonal(5)))
disp(matrizJacobi(tridiagonal(7)))

/*
   n = 5
   
   0.   0.5       0.       0.      0.  
   0.   0.25      0.5      0.      0.  
   0.   0.125     0.25     0.5     0.  
   0.   0.0625    0.125    0.25    0.5 
   0.   0.03125   0.0625   0.125   0.25

   n = 7
   
   0.   0.5         0.         0.        0.       0.      0.  
   0.   0.25        0.5        0.        0.       0.      0.  
   0.   0.125       0.25       0.5       0.       0.      0.  
   0.   0.0625      0.125      0.25      0.5      0.      0.  
   0.   0.03125     0.0625     0.125     0.25     0.5     0.  
   0.   0.015625    0.03125    0.0625    0.125    0.25    0.5 
   0.   0.0078125   0.015625   0.03125   0.0625   0.125   0.25
   
*/
