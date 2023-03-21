/*
    f string que representa funcion
    a punto donde se calcula el polinomio
    x es el valor donde se evaluara el polinomio
    n es el grado del polinomio
    h es el paso con el cual se calcula la derivada
    resultado = valor de evaluar el polinomio de taylor de grado n en x.
*/

function resultado = TaylorFun(f, a, x, n, h)
    // Definicion de DF0 para poder evaluarla.
    deff("y = DF0(x)", "y="+f);
    // Primer termino del polinomio.
    resultado = DF0(a);
    // Variable xpoli, x del polinomio, para poder evaluarlo luego con honer
    xpoli = poly([0 1], "x", "coeff");
    // Si el grado es 0, se devuelve el primer termino, no se hace nada mas.
    if n <> 0 then
        for i=1:(n-1)
            // Funcion derivada que se utiliza para calcular otras, queda bien definida.
            deff("y=DF"+string(i)+"(x)", "y=numderivative(DF"+string(i-1)+",x,"+string(h)+",4)");
            // Funcion auxiliar para poder evaluar la deriva i-esima.
            deff("y = aux(x)", "y=DF"+string(i)+"(x)");
            // Se agrega al polinomio resultado el termino i, utilizando la derivada recien definida.
            resultado = resultado + (1/factorial(i)) * ((xpoli-a)^i) * aux(a);
            
            // En cada iteracion resultado es el polinomio de taylor de f de grado i.
        end
        // Ultimo termino del polinomio.
        deff("y=DFn(x)", "y=numderivative(DF"+string(n-1)+",x,"+string(h)+",4)");
        resultado = resultado + (1/factorial(n)) * ((xpoli-a)^n) * DFn(a);
    end
    // Se evalua el polinomio construido, si se quiere calcular sobre la marcha, se puede 
    // reemplazar xpoli por x, lo cual no construye un polinomio sino que evalua cada termino
    // mientras se calcula.
    resultado = horner(resultado, x);
endfunction

/*
Ejemplos:
    TaylorFun("((8+x)^(1/2))-2", 1, 2, 3, 0.1) = 1.1622942
    TaylorFun(string(%e)+"^x", 0, 2, 5, 0.1) = 7.2666198
    TaylorFun("x^2", 2, 2, 5, 0.1) = 4
*/

