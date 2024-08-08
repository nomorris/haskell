Q = (Double, Double, Double, Double)

add :: Q -> Q -> Q
add (a,b,c,d) (e,f,g,h) = (a+e,b+f,c+g,d+h)


sub :: Q -> Q -> Q
sub (a,b,c,d) (e,f,g,h) = (a-e,b-f,c-g,d-h)


mul :: Q -> Q -> Q
mul (a,b,c,d) (e,f,g,h) = (a*e - b*f - c*g - d*h, 
                           a*f + b*e - c*h - d*g, 
                           a*g + c*e - b*h - d*f, 
                           a*h + d*e - b*g - c*f)

inv :: Q -> Q
inv (0,0,0,0) = error
inv (a,b,c,d) = let z = a^2 + b^2 + c^2 + d^2 in (a/z,-b/z,-c/z,-d/z)


one,i,j,k :: Q
one = (1,0,0,0)
i   = (0,1,0,0)
j   = (0,0,1,0)
k   = (0,0,0,1)
