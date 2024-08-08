> setIn :: Integer -> [Integer] -> Bool
> setIn a (b:bs) = if a==b then True else setIn a bs

> wellForm :: [Integer] -> [Integer]
> wellForm (a:as) = if setIn a as then wellForm as else a:(wellForm as) 


> subset :: [Integer] -> [Integer] -> Bool
> subset []     bs = True
> subset (a:as) bs = if setIn a bs then contains as bs else False

> setEq :: [Integer] -> [Integer] -> Bool
> setEq as bs = (subset (wellForm bs) (wellForm as)) && (subset (wellForm as) (wellForm bs))