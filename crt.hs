(//)=div
(%)=mod

--annoying how the Chinese Remainder Theorem is usually stated like "it's possible to do this" without describing an algorithm. 

crt :: [(Int, Int)] -> (Int, Int)
crt [] = (0, 1)
crt ((r1,m1):xs) = 
  let (r2,m2) = crt xs in
  let a = fst $ gcdCoeff m2 m1 in 
  ((m2*(r1-r2)*(a%m1) + r2) % (m1*m2), m1*m2)


-- g = gcd(x,y). Ǝ a,b ϵ Z | ax + by = g. 

gcdCoeff 0 b = (0, 1)
gcdCoeff a b = let (s, t) = gcdCoeff (b % a) a 
               in  (t - s*(b//a), s)            
               