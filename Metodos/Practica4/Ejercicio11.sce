clc
clear

function [R] = cholesky(A)
    // Factorización de Cholesky.
    // Trabaja únicamente con la parte triangular superior.


    //******************
    eps = 1.0e-8
    //******************
    
    n = size(A,1)
    R = zeros(n,n)
    
    for k = 1:n
        t = A(k,k) - R(1:k,k)'*R(1:k,k)
        
        if t <= eps then
            printf('Matriz no definida positiva.\n')
            R = []
            return
        end

        R(k,k) = sqrt(t)
        for j = k+1:n
            R(k,j) = (A(k,j) - R(1:k,k)'*R(1:k,j))/R(k,k)
        end
    end

endfunction


// a)
A = [16 -12 8 -16;-12 18 -6 9;8 -6 5 -10;-16 9 -10 46]

[R] = cholesky(A)
disp(R)
disp(R'*R)

/*
 R =
   4.  -3.   2.  -4.
   0.   3.   0.  -1.
   0.   0.   1.  -2.
   0.   0.   0.   5.

  
  R'*R =
   16.  -12.   8.   -16.
  -12.   18.  -6.    9. 
   8.   -6.    5.   -10.
  -16.   9.   -10.   46.
*/

// b)
A = [4 1 1;8 2 2;1 2 3]

[R] = cholesky(A)
disp(R)
disp(R'*R)

/*
 R =
   2.    0.          0.
   0.5   1.3228757   0.
   0.5   1.3228757   1.
  
  R'*R =

   4.   1.   1.
   1.   2.   2.
   1.   2.   3.
   
   // La matriz no es hermitiana, por lo tanto la factorizacion de cholesky es incorrecta
*/

// c)
A = [1 2;2 4]

[R] = cholesky(A)

/*
   La matriz no es definida positiva
*/

/*
Ejemplos de ejecucion.

A = [4 12 -16; 
    12 37 -43;
    -16 -43 98]
    
cholesky(A) =

R =
   2.   6.  -8.
   0.   1.   5.
   0.   0.   3.

R'*R =
   4.    12.  -16.
   12.   37.  -43.
  -16.  -43.   98.


A = [16 -12 -12 -16;
    -12 25 1 -4;
    -12 1 17 14;
    -16 -4 14 57]
cholesky(A) =

R =
   2.   6.  -8.
   0.   1.   5.
   0.   0.   3.
   
R'*R
   4.    12.  -16.
   12.   37.  -43.
  -16.  -43.   98.
*/


