(//) = div
(%) = mod
(/%/) = divMod

bxor :: Int -> Int -> Int 
bxor x y = 
  if x<2 && y<2 
    then if x /= y then 1 else 0
    else let ((dx, mx), (dy, my)) = (x /%/ 2, y/%/ 2)
         in (if x /= y then 1 else 0) + 2 * (bxor dx dy)

nimbot :: [Int] -> [Int]
nimbot xs = remove (foldr bxor 0 xs)  xs 

remove :: Int -> [Int] -> [Int]
remove _ [] = []
remove n (x:xs) | n<=x = (x-n) : xs 
remove n (x:xs) = x : remove n xs