clc
clear

function sol = triangular_inf(A, b)
    n = size(A)(1)
    x(1) = b(1)/A(1,1)
    for i=2:1:n
        x(i) = (b(i) - A(i,1:i-1) * x(1:i-1))/A(i,i)
    end
    sol = x
endfunction


function sol = triangular_sup(A, b)
    n = size(A)(1)
    x(n) = b(n)/A(n,n)
    for i=n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n))/A(i,i) 
    end
    sol = x
endfunction


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
            R(k,j) = ( A(k,j) - R(1:k,k)'*R(1:k,j) )/R(k,k)
        end
    end
endfunction

function x=resolverCholesky(A, b)
    R = cholesky(A)
    x = triangular_sup(R,triangular_inf(R', b))
endfunction

A = [16 -12 8;
    -12 18 -6;  
     8 -6 8]
b = [76;-66;46]

// Realizo un procedimiento similar al de LUx=b
// Resuelvo R'y=b y luego Rx=y
// Tenemos la ventaja de que R es triangular
disp(resolverCholesky(A,b))

/*
R = 
   4.  -3.   2.
   0.   3.   0.
   0.   0.   2.

x= 
   3
  -1
   2
*/


/*
Ejemplos:

A = [16 -12 -12 -16;
    -12 25 1 -4;
    -12 1 17 14;
    -16 -4 14 57]
b = [5 2 3 4]

resolverCholesky(A,b) =

x =
   9.5598145
   4.7548828
   5.1425781
   1.8242188
------------------------------------------------------------------------
A = [4 12 -16; 
    12 37 -43;
    -16 -43 98]
b = [5 -2 4]

resolverCholesky(A,b) =

x =
   282.36111
  -77.555556
   12.111111
 
------------------------------------------------------------------------
A = [16 -12 8 -16;-12 18 -6 9;8 -6 5 -10;-16 9 -10 46]

b = [-1 -4 -1 -1]

resolverCholesky(A,b) =

x =
  -0.2541667
  -0.5888889
  -0.8666667
  -0.1833333

*/

