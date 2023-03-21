clc

clear

/*
    Calcula el maximo valor absuluto de los autovalores
    de la matriz A
*/
function y=radioEspectral(A)
    y = max(abs(spec(A)))
endfunction

/*
    Funcion que chequea si la matriz es diagonal dominante, es decir
    si |A(i,i)| > sumatoria j = 1 a n con j distinto a i de |A(i,j)|
*/
function res = diagonalDominante(A)
    [nA, mA] = size(A)
    
    // Por cada columna chequeamos la condicion.
    for i = 1:nA
        suma = 0
        // Ciclo que realiza la sumatoria de los elementos de la fila
        // distintos de la diagonal.
        for j = 1:mA
            if j <> i
                suma = suma + abs(A(i,j))
            end
        end
        // Chequeo si la suma no cumple la condicion, si no lo hace la 
        // matriz no es diagonal dominante.
        if suma >= abs(A(i,i))
            res = 0
            return
        end
    end
    res = 1
endfunction

/*
    I = eye(3,3)
    diagonalDominante(I) = 1
    A = [5 2 2; 1 6 2; 1 1 6]
    diagonalDominante(A) = 1
    B = [5 2 3; 1 6 2; 1 1 6]
    diagonalDominante(B) = 0
    C = [1 6 2; 1 1 6;5 2 3]
    diagonalDominante(C) = 0
*/

/*
    Funcion que dada una matriz y la matriz del metodo, teste si el
    mismo convergera para todo x0 incial bajo el metodo correspondiente.
*/
function res = metodoTest(A, N)
    
    // Primera condicion si la matriz es diagonal diagonal.
    if diagonalDominante(A) == 1
        res = 1
        disp("Matriz diagonal dominante")
        return
    end
    
    // Si no es diagonal chequeo la acotacion de las normas de la
    // matiz de iteracion.
    
    if det(N) == 0
        res = 0
        disp("Matriz N singular")
        return
    end
    
    n = size(A)(1)
    I = eye(n,n)
    // Calculo de matriz de iteracion.
    matrizItera = I - inv(N)* A
    n(1) = norm(matrizItera, 1)
    n(2) = norm(matrizItera, 'inf')
    n(3) = norm(matrizItera, 'fro')
    n(4) = norm(matrizItera)
    if min(n) < 1
        res = 1
        disp("Matriz con alguna norma acotada por 1")
        return
    end
    
    // Si las normas no estan acotadas, verifico si el radio 
    // espectral si.
    if radioEspectral(matrizItera) < 1
        res = 1
        disp("Radio espectral acotado por 1")
        return
    end
    
    // Si llegamos aca es que no se cumplio ninguna condicion de 
    // convergencia.
    res = 0
     
endfunction

function x = jacobi(A,b,x0,eps) 
    
    n = size(A,1)
    x = x0
    xant = x
    suma = 0
    cont = 0
    
    while(abs(norm(x-xant)) > eps | cont == 0) 
        xant = x
        for i = 1:n
            suma = 0
            for j = 1:n 
                if (i <> j)
                    suma = suma + A(i,j)*xant(j)
                end
            end
            x(i) = 1/(A(i,i))*(b(i)-suma)
        end
        cont = cont + 1
    end
    
    mprintf("Cantidad de iteraciones: %d\n",cont)
endfunction

function x = gaussseidel(A,b,x0,eps)  
    n = size(A,1)
    x = x0
    xant = x
    suma = 0

    cont = 0
    
    while(abs(norm(x-xant)) > eps | cont == 0) 
    xant = x
        for i = 1:n
            suma = 0
            for j = 1:n 
                if (i<>j)
                    suma = suma + A(i,j)*x(j)
                end
            end
            
            x(i) = 1/(A(i,i))*(b(i)-suma)
        end
     cont = cont + 1
    end
    
    mprintf("Cantidad de iteraciones: %d\n",cont);
endfunction


A=[10 1 2 3 4; 1 9 -1 2 -3; 2 -1 7 3 -5; 3 2 3 12 -1; 4 -3 -5 -1 15]
b=[12 -27 14 -17 12]
x0 = [0 0 0 0 0]


disp(metodoTest(A, diag(diag(A))))
/* 
    metodoTest(A, tril(A)) = 1
    Radio espectral acotado por 1
    Jacobi en A converge
*/


disp(metodoTest(A, tril(A)))
/* 
    metodoTest(A, tril(A)) = 1
    Radio espectral acotado por 1
    Gauss-Seidel en A converge
*/


disp("Jacobi")
disp(jacobi(A, b, x0, 0.000001))
/*
    jacobi(A, b, x0, 0.000001) = 
    
    1.0000016  -2.0000015   2.9999973  -1.9999996   0.9999981
    
    Con 67 iteraciones.
*/


disp("Gauss-Seidel")
disp(gaussseidel(A, b, x0, 0.000001))
/*
    gaussseidel(A, b, x0, 0.000001) =
    
    1.0000009  -2.0000007   2.9999987  -1.9999999   0.9999992

    Con 38 iteraciones.
*/



