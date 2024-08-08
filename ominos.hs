allB3Nums :: Int -> [[Int]]
allB3Nums n = let g = go (n-1) in (map (1:) g) ++ (map (2:) g)
  where go 0 = [[]] 
        go n = let xs = go (n-1) 
               in concat [map (i:) xs | i <- [0..2]]           
               
-- numPolyominoes :: Int -> Int 
numPolyominoes n = filter (\xs -> sum xs == (n-1)) (allB3Nums (n-1))