format(25);

// Ejercicio 1:
function r = misraices(p)
    c = coeff(p,0);
    b = coeff(p,1);
    a = coeff(p,2);
        if b < 0 then
            r(2) = (2*c)/(-b + sqrt(b^2-4*a*c));
            r(1) = (-b + sqrt(b^2-4*a*c))/(2*a);
        elseif b > 0 then
            r(1) = (2*c)/(-b - sqrt(b^2-4*a*c));
            r(2) = (-b - sqrt(b^2-4*a*c))/(2*a);
        end
endfunction

p = poly([-0.0001 10000.0 0.0001],"x","coeff");
valorEsperado = 1e-8;

raicesMias = misraices(p);
raicesScilab = roots(p); 

errorMio = abs(raicesMias(1)-valorEsperado)/valorEsperado;
errorScilab = abs(raicesScilab(2)-valorEsperado)/valorEsperado;

printf("Esperado : %e\n", valorEsperado);
printf("misraices (nuestro) : %e  (error= %e)\n", raicesMias(1), errorMio)
printf("roots (Scilab) : %e (error= %e)\n", raicesScilab(2), errorScilab);
printf("Puedo concluir que la funcion misRaices calcula de la misma manera que scilab. En este caso no tenemos error");


