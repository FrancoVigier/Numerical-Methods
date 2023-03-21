clc

clear


// Ejercicio 6


x = poly([0 1], "x", "coeff")

p = 2+(x+1)+(x+1)*(x-1)*-2+(x+1)*(x-1)*(x-2)*2
disp("Valor f(0)")
disp(horner(p,0))
// = 9

err = (x+1)*(x-1)*(x-2)*33.6*(1/factorial(4))

disp(horner(err,0))
// err < 2.799999999999999822364
