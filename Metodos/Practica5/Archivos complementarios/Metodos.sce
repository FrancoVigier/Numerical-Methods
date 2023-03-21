clc

clear

// Metodo de jacobi

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


A = [1 -1 0; -1 2 -1; 0 -1 1.1]
b = [0 1 0]
x0 = [0 0 0]

disp(jacobi(A, b,x0, 0.00001))


// Metodo de Gauss-Seidel
// xi^(k+1) = 1/aii (bi - sum_{j=1}^{i-1} aij xj^{k+1} - sum_{j=i+1}^{n} aij xj^{k})

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

A = [1 -1 0; -1 2 -1; 0 -1 1.1]
b = [0 1 0]
x0 = [0 0 0]

disp(gaussseidel(A, b,x0, 0.00001))


spec(A) //Espectro
function x=metodoIterativo(A,N,b,x0,eps)
    
    x = x0
    xant = x
    invN = inv(N)
    cont = 0
    while (abs(norm(x-xant)) > eps | cont == 0)
        xant = x
        x = invN * (N-A)*xant + invN * b
        cont = cont + 1
    end
    
endfunction

