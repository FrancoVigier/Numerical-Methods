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
e1 = 1e-8;
roots1 = misraices(p);
r1 = roots1(1);
roots2 = roots(p);
r2 = roots2(2);
error1 = abs(r1-e1)/e1;
error2 = abs(r2-e1)/e1;
printf("Esperado : %e\n", e1);
printf("misraices (nuestro) : %e (error= %e)\n", r1, error1);
printf("roots (Scilab) : %e (error= %e)\n", r2, error2);

// Ejercicio 3-b
function y = horner2(p, x0)
    grado = degree(p);
    anterior = coeff(p, grado); // anterior = bn
    
    while 0 < grado
        grado = grado - 1;
        anterior = coeff(p, grado) + (x0 * anterior);
    end
    y = anterior;
endfunction

p = poly([1 1 1], "x", "coeff");


function y = horner_generalizacion(p, x0)
    grado = degree(p);
    anterior = coeff(p, grado); // anterior = bn
    z = poly([0 1], "x", "coeff");
    z = z^(grado-1)
    disp(z);
    resultado = 0;
    while 1 < grado
        grado = grado - 1;
        z = z + z^grado * (coeff(p, grado) + (x0 * anterior));
    end
    y = z;
endfunction

disp(horner_generalizacion(p,3))

clear// borra el contenido de la memoria
xdel(winsid())// cierra ventanas gr ́aficas
// Definici ́on de la funci om
function y = f(x)
y = %e^x;
endfunction// C ́alculo de la derivada utilizando diferencias finitas
function y = deriva(f, x, n, h)
    if n == 0 then
        y = f(x);
    else 
        y =(deriva(f, x+h, n-1, h) - deriva(f, x, n-1, h))./h;
    end
endfunction

function y = deriva2(f, v, n, h)
    deff("y = DF0(x)", "y="+f)
    if n == 0 then
        y = f(v);
    else
        for i=1:(n-1)
            deff("y=DF"+string(i)+"(x)","y=(DF"+string(i-1)+"(x+"+string(h)+")-DF"+string(i-1)+"(x))/"+string(h));
        end
        deff("y=DFn(x)", "y=(DF"+string(n-1)+"(x+"+string(h)+")-DF"+string(n-1)+"(x))/"+string(h));
        y = DFn(v);
    end
endfunction

function y = deriva3(f, v, n, h)
    deff("y = DF0(x)", "y="+f)
    if n == 0 then
        y = f(v);
    else
        for i=1:(n-1)
            deff("y=DF"+string(i)+"(x)", "y=numderivative(DF"+string(i-1)+",x,"+string(h)+",4)");
        end
        deff("y=DFn(x)", "y=numderivative(DF"+string(n-1)+",x,"+string(h)+",4)");
        y = DFn(v);
    end
endfunction

x = 1;// Punto donde vamos a evaluar la derivada
ih = (0:16)';
h = (10.^-ih);// Vector con los valores de h
disp(deriva2("x^3+x+x^2",x,1,0.0001));
disp(deriva3("x^3+x+x^2",x,1,0.0001));

function y = taylor(n, fp, v)
    // Para poder evauluar fp
    deff("y = fu(x)", "y="+fp);
    resultado = fu(v);
    // Variable x
    x = poly([0 1], "x", "coeff");
    for i=1:n
        resultado = resultado + (1/factorial(i))*deriva3(fp, v, i, 0.1)*(x-v)^i;
    end
    y = resultado;
endfunction
//disp(deriva3("2.71828182846^x", 0, 6, 0.1));
disp(taylor(9,string(%e)+"^x", 0));

function y = taylor2(n, fp, v)
    resultado = fp(v);
    // Variable x
    x = poly([0 1], "x", "coeff");
    for i=1:n
        resultado = resultado + (1/factorial(i))*deriva(fp, v, i, 0.1)*(x-v)^i;
    end
    y = resultado;
endfunction
disp(horner(taylor2(9, f, 0), -2));
/*
dfapprox = deriva2("x^3",x,1,0.0001);// Evaluaci ́on de la derivada por diferencias finita
dfscilab = deriva3("x^3",x,1,0.0001);// Derivada obtenida por numderivative
dftrue = 2;// Valor verdadero de la derivada en x = 1
// Errores absolutos y relativos
errabs = abs(dfapprox - dftrue);
errrel = errabs./abs(dftrue);
errabssci = abs(dfscilab - dftrue);
errrelsci = errabssci/abs(dftrue);// Gr ́afic
plot(ih,log10(errrel),'b*-');// Gr ́afica en escala logar ́ıtmica en el eje
 title('Error relativo utilizando diferencias finitas');
 xlabel('i');
 ylabel('$log{10}(Err Rel)$');
 plot(ih,log10(errrelsci*ones(length(ih),1)),'r-');// Impresi ́on de resultados en pantalalla
 tablevalue = [ih,h,dftrue*ones(length(h),1),dfapprox,errabs,errrel];
 mprintf(' %s\n',strcat(repmat('-',1,80)));
 mprintf(' %4s %8s %12s %18s %14s %14s\n',...
 'i', 'h','Der. exact','Der approx','Abs. error','Rel. error');
 mprintf(' %s\n',strcat(repmat('-',1,80)));
 mprintf(' %4d %8.1e %9.6e %18.10e %14.5e %14.5e\n',tablevalue);
 mprintf(' %s\n',strcat(repmat('-',1,80)));
 mprintf(' %4.1s %8s %9.6e %18.10e %14.5e %14.5e\n',...
 ' ', 'Scilab',[dftrue,dfscilab,errabssci,errrelsci]);
 mprintf(' %s\n',strcat(repmat('-',1,80)));
 /*
function y = derivar(f, v, n, h)
    if n == 0 then
        y = f(v);
    else
        y = ((derivar(f,v+h,n-1,h) - derivar(f,v,n-1,h))./h);
    end
          
    
endfunction

function y = f(x)
    y = x^3;
endfunction


ih = (0:16)';
h = (10.^-ih);

disp(derivar(f, 2, 4, h));*/
    
