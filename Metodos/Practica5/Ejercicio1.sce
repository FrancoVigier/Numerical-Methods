clc

clear

// Ejercicio 1-a)

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
    
    // Primera condicion si la matriz es diagonal dominante.
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

/*
    I = eye(3,3)
    metodoTest(I) = 1

    A = [5 2 2; 1 6 2; 1 1 6]
    metodoTest(A) = 1
    
    B = [5 2 3; 1 6 2; 1 1 6]
    metodoTest(B, tril(B)) = 1
    
    C = [1 6 2; 1 1 6; 5 2 3]
    metodoTest(C, tril(c)) = 0
*/

/*
    Funcion implementacion del metodo de Jacobi
*/
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


/*
    Funcion implementacion del metodo de Gauss-Seidel
*/
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


//  Ejercicio 1-a)
//  Chequeo con Jacobi

disp("Ejercicio 1-a) matriz 1:")

//  Matriz 1

A = [0 2 4; 1 -1 -1; 1 -1 2]
b = [0; 0.375; 0]

disp(metodoTest(A, diag(diag(A))))

/* 
    metodoTest(A, tril(A)) = 0
    Esto es pues N = tril(A) es singular, pruebo ahora intercambiando
    filas de A.
    En particular intercambio la primera con la segunda.
*/

A = [1 -1 -1; 0 2 4; 1 -1 2]
b = [0.375; 0; 0]

disp(metodoTest(A, diag(diag(A))))

/* 
    metodoTest(A, tril(A)) = 0
    Esto es porque no cumple las condiciones necesarias para la
    convergencia. No podemos asegurarla.
*/


// Matriz 2

disp("Matriz 2")

A = [1 -1 0; -1 2 -1; 0 -1 1.1]
b = [0; 1; 0]

disp(metodoTest(A, diag(diag(A))))

/*
    metodoTest(A, tril(A)) = 1
    Esto es que la matriz cumple alguna de las condiciones de 
    convergencia por lo tanto podemos asegurar que converge para todo x0
    con el metodo de jacobi.
    
    Radio espectral acotado por 1.
*/


//  Ejercicio 1-b)

//  Matriz 1
//  Chequeo con Gauss-Seidel

disp("Ejercicio 1-b) matriz 1")

A = [0 2 4; 1 -1 -1; 1 -1 2]
b = [0; 0.375; 0]

disp(metodoTest(A, tril(A)))

/*
    Nuevamente, N es singular por lo que intentare solucionarlo con
    una permutacion de filas. La 1ra por la 2da.
*/

A = [1 -1 -1; 0 2 4; 1 -1 2]
b = [0.375; 0; 0]

disp(metodoTest(A, tril(A)))

/*
    Veo que la matriz no cumple con las condiciones de convergencia
    por lo tanto tampoco convergerá en este metodo.
*/

// Matriz 2

disp("Matriz 2")


A = [1 -1 0; -1 2 -1; 0 -1 1.1]
b = [0; 1; 0]

disp(metodoTest(A, tril(A)))

/*
    Veo que bajo este metodo la matriz N tiene el radio espectral 
    acotado por 1 por lo tanto es convergente bajo el metodo de 
    Gauss-Seidel
*/


// Ejercicio 1-c)

// Lo realizare con la matriz 2 pues es la que se que convergerá.

// Metodo de Jacobi

disp("Solucion del sistema 2 con Jacobi")


disp(jacobi(A,b,x0,0.01))

/*
    jacobi(A,b,x0,0.01) =
    
    10.789086
    10.798673
    9.8082602
    
    con 171 iteraciones.
*/


disp("Solucion del sistema 2 con Gauss-Seidel")

disp(gaussseidel(A,b,x0,0.01))

/*
    gaussseidel(A,b,x0,0.01) =
    
    10.873565
    10.879312
    9.8902836
    
    con 97 iteraciones
    
    Puedo observar una mejoria con respecto al metodo de Jacobi, lo que
    tiene sentido dado cada uno de los algoritmos.
*/

/*
    La solucion del sistema calculada con el metodo de eliminacion de
    Gauss es
    
    11
    11
    10
    
*/

