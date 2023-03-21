function y = taylor(n, fp, v)
    // Para poder evauluar fp
    deff("y = fu(x)", "y="+fp);
    resultado = fu(v);
    // Variable x
    x = poly([0 1], "x", "coeff");
    for i=1:n
        // h = 0.1 no siempre es el adecuado (para e^x funciona bien)
        // deriva3 funcion de derivacion usando numderivative.
        // Se conforma el polinomio de taylor
        // 1/n! * f(n)(a)(x-a)^n
        
        // Para derivar estoy usando la funcion definida con numderivative
        resultado = resultado + (1/factorial(i))*deriva3(fp, v, i, 0.1)*(x-v)^i;
    end
    y = resultado;
endfunction

// Ejemplo con e^x en a = 0.
funcion = string(%e)+"^x";

a = taylor(10, funcion, 0);

disp(a);
printf("Polinomio evaluado en -2: %e\n Evaluado en 2 y hecho reciproco %e", horner(a, -2), 1/horner(a, 2));


/* Es mejor aproximacion 1/e^2

Cuando calculamos el polinomio de taylor de e^x en a = 0, todos los terminos son 
positivos, pero cuando lo evaluamos en x = -2, los que tienen exponente impar,
seran negativos y los de exponente par seran positivos. Por lo tanto tendremos 
porblema de supresion de sifras significativas.
En el ejemplo es claro ver como con el polinomio de orden 7 tiene menor error el calculo
de 1/e^2
Polinomio evaluado en -2: 1.301598e-01
Evaluado en 2 y hecho reciproco 1.354848e-01

*/

// Esta funcion utiliza horner para evaular el polinomio a la vez que se 
// conforma el polinomio de taylor.
function resultado = taylor_horner(n, fp, v, x0)
    anterior = (1/factorial(n))*deriva3(fp, v, n, 0.1);
    i = n;
    while i > 0
        i = i - 1; 
        // b1 = ai + x0 * bi-1
        // con ai = 1/!1 * f'(v)
        anterior = (1/factorial(i))*deriva3(fp, v, i, 0.1) + (x0 * anterior);
    end
    resultado = anterior;
endfunction

