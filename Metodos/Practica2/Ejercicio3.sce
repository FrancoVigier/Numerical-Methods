// Ejercicio 3-b)


function y = horner2(p, x0)
// Para calcular el polinomio de horner debemos emepezar de atras hacia
// adelante.
    grado = degree(p);
    anterior = coeff(p, grado); // anterior = bn
    
    // Recorro cada termino del polinonio desde el de mayor grado al menor.
    while 0 < grado
        grado = grado - 1;
        // Calculo cada bi.
        // bi = ai + x0 * bi+1
        anterior = coeff(p, grado) + (x0 * anterior);
    end
    // Devulevo el b0
    y = anterior;
endfunction

// Ejercicio 3-d)

function r = horner_mejorado(p, x0)
// Se trabaja de manera similar al anterior solo que en el ciclo se 
// calcula a su vez el polinomio de horner del polinomio de horner.
    grado = degree(p);
    anterior = coeff(p, grado); // anterior = bn
    // anterior del polinio q 
    anteriorq = anterior;
    while 0 < grado
        grado = grado - 1;   
        // El polinomio q no tiene en cuenta el termino libre del 
        // polinomio p.
        if grado <> 1 then
            // Se calcula cada coeficionete de q0
            anteriorq = anterior + anteriorq*x0;
        end
        // Se calcula cada coeficiente de p.
        // bi = ai + x0 * bi+1
        anterior = coeff(p, grado) + (x0 * anterior);
    end
    r(1) = anterior;
    r(2) = anteriorq;
endfunction

// Ejemplo de ejecucion:

p = poly([3 5 6], "x", "coeff");
disp(p);
disp(horner_mejorado(p, 2)(1));
disp(horner_mejorado(p, 2)(2));

/*
p = 3+5x+6x^2

p(2) = 37

p'(2) = 29

*/
