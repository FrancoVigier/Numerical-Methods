clc

clear

function sol = triangular_sup(A, b)
    n = size(A)(1)
    // Despejo la ultima incongnita
    x(n) = b(n)/A(n,n)
    // con el resultado obtenido despejo uno nueva y asi sucesivamente.
    for i=n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n))/A(i,i) 
    end
    sol = x
endfunction


A = [2 6 4;
     0 8 1;
     0 0 9]
b = [1 2 3]

disp(triangular_sup(A, b))

/* 
triangular_sup(A, b) =
    -0.7916667
    0.2083333
    0.3333333
*/

A = [-3 6 5;
     0 8 -2;
     0 0 5]
b = [6 1 -2]

disp(triangular_sup(A, b))

/*
triangular_sup(A, b)
    -2.6166667
    0.025
    -0.4
*/

A = [-3 6 5 5;
     0 8 -2 9;
     0 0 5 -2;
     0 0 0 -1]
b = [6 1 -2 3]

disp(triangular_sup(A, b))

/*
triangular_sup(A, b) =
    -3.4666667
    3.1
    -1.6
    -3.
*/

// En esta funcion se opera de la misma manera que en la anterior.
function sol = triangular_inf(A, b)
    n = size(A)(1)
    x(1) = b(1)/A(1,1)
    for i=2:1:n
        x(i) = (b(i) - A(i,1:i-1) * x(1:i-1))/A(i,i)
    end
    sol = x
endfunction

A = [9 0 0; 1 8 0; 4 6 2]
b = [3 2 1]
disp("Testeo triangular inferior")

disp(triangular_inf(A, b))

/* triangular_inf(A, b) = 
    0.3333333
    0.2083333
    -0.7916667
*/

A = [9 0 0;
     1 8 1;
     4 6 2]
b = [3 2 1]

disp(triangular_inf(A, b))

/* 
triangular_inf(A, b) =
    0.3333333
    0.2083333
    -0.7916667
*/

A = [5 0 0;
    -2 8 0;
    5 6 -3] 
b = [-2 1 6]

disp(triangular_inf(A, b))

/*
triangular_inf(A, b)
    -0.4
    0.025
    -2.6166667
*/

A = [-1 0 0 0;
     -2 5 0 0;
     9 -2 8 0;
     5 5 6 -3]
b = [3 -2 1 6]

disp(triangular_inf(A, b))

/*
triangular_inf(A, b) =
    -3.
    -1.6
    3.1
    -3.4666667
*/
