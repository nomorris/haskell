bas

In this section we will be exploring bases. We will take integers as a given, 
and explore rational and real representations like floating-point and continued
fractions. We'll program in alternate bases, touch on p-adics, and ultimately wind
up at the Basel problem.


When one divides by three, the result repeats infinitely. This is unfathomable. What will we do.

It is ok. It is just periodic. All rational numbers have an infinite, but periodic decimal, such as 

4/1  = 4.(0 repeating)

1/7  = 0.(142857 repeating)

1/3  = 0.(3 ...)

3/12 = 0.375(0 ...)

and so on, using the ellipses to mean "what precedes repeats forever". 

One type of number that is not rational is called an irrational. An example is the square root of five, which goes something like 

2.2360679774997896964091736687312762354406183596115257242708972454105209256378048994144144083787822749695081761507737835042532677244470738635863601215334527088667781731918791658112766453226398565805357613504175337850034233924140644420864325390972525926272288762995174024406816117759089094984923713907297288984820886415426898940991316935770197486788844250897541329561831769214999774248015304341150359576683325124988151781394080005624208552435422355561063063428202340933319829339597463522712013417496142026359047378855043896870611356600457571399565955669569175645782219525000605392312340050092867648755297220567662536660744858535052623306784946334222423176372770266324076801044433158257335058930981362263431986864719469899701808189524264459620345221411922329125981963258111041704958070481204034559949435068555518555725123886416550102624363125710244496187894246829034044747161154557232017376765904609185295756035779843980541553807790643936397230287560629994822138521773485924535151210463455550407072278724215347787529112121211843317893351910380080111181790045906188462496471042442483088801294068113146959532794478989989316915774607924618075006798771242048473805027736082915599139624489149435606834625290644083279446426808889897460463083535378750420613747576068834018790881925591179735744641902485378711461940901919136880351103976384360412810581103786989518520146970456420217638928908844463778263858937924400460288754053984601560617052236150903857754100421936849872542718503752155576933167230047782698666624462106784642724863852745782134100679856453052711241805959728494551954513101723097508714965294362829025400120477803241554644899887061779981900336065622438864096392877535172662959714382279563079561495230154442350165389172786409130419793971113562821393674576811749220675621088878188736716716276226233798771115395096829828906830182590814010038955097232615084528345878936073463961172366783665719826079214402891190089955842415224957129183232167411899757201394037881977280152887234186683454183828673002743153202296076286125247610286423469630201118026912202360158101276284305418617176...

And will say the same sort of thing in any rational base. So here's the issue: we cannot represent this style of number as a predictable pattern of integers. This is the big idea:


   415 / 93 = 4 +          1
				  ______________________
					 2    +    1
						 _______________
						  6 +      1
								________
								   7 

All rational numbers have a finite representation along these lines, as a continued fraction. Starting with any rational, we can apply Euclid's GCD algorithm, like 

415 /%/ 93 = (4, 43) 
 93 /%/ 43 = (2, 7) 
 43 /%/  7 = (6, 1) 
  7 /%/  1 = (7, 0) 
  
Basically just long division

	 4
   ___________
93|415        
  -372 = 43

	  
  
  
getting us all of the information we'd need to fill in a template version of what's up there. This is nice: absolute precision for all rational numbers, and one canonical description per rational. In the case of 
 
  415  
 _____  =  4.(462365591397849 ...) we could store the number merely as [4,2,6,7]. 
  93

> (/%/) :: Integer -> Integer -> (Integer, Integer)
> a /%/ b = a `divMod` b
 
> rationalToCF :: Integer -> Integer -> [Integer]
> rationalToCF a 0 = [] 
> rationalToCF a b = do 
>   let (a',b') = a /%/ b
>   a':(rationalToCF b b')

ghci> rationalToCF 415 93 = [4,2,6,7]

ghci> rationalToCF 7487 12365 = [0,1,1,1,1,6,1,2,15,1,6]

This is cool for numbers whose exact numerator and denominator we know, but how about decimals where we don't know? Uhh, let's check https://www.math.u-bordeaux.fr/~pjaming/M1/exposes/MA2.pdf.



 
There are plenty of reasons that this trick works, one of which is that the harmonic series 
diverges. Anyway, with these, we can apply Euclid's cracked/jailbroke incommensurable variant 
of the GCD algorithm, and depict irrational numbers in another way, which also repeats forever.
Now, though, some repeat predictably, like 


19 ^ 1/2 = [4;(2,1,3,1,2,8 ...)]

e        = [2;1,2,1,1,4,1,1,(p+2,1,1 ...)]

2  ^ 1/2 = [1;(2 ...)]

phi      = [1 ...]

In general, any periodic continued fraction represents a root of a quadratic equation with integer coefficients (if we count the rationals repeating zero forever, and acknowledge that e is there on a technicality).

Floating Point is not optimized for numbers like square roots and e, despite those are pretty 
common I think. It is also not sorted to where storing integers is pretty much as good as a 
normal integer, in terms of arithmetic error and storage space. 

If I may engage the reader emotionally, I recently watched a lovely Youtube personality spend 
an hour doing really cool stuff with the Collatz conjecture, writing some algorithms to fetch 
arbitrary configurations from the Tree. They were in Python, and as such, floating point error 
ended the project once numbers got sufficiently large. I'm not against decimal values: we could
linearly interpolate "2x" and "3x+1" by the real number mod 2 (i.e., 3.67 % 2 = 1.67),turning "even" and "odd" to poles along a spectrum, but that's a whole other thing. 

Uhh where was I uhh

oh thiss is dope

43/19 = [2;3,1,4]   |   19/43 = [0;2,3,1,4]
 3/7  = [0;2,3]     |    7/3  = [2;3]

Esp. when you consider that "rolling" a rational continued fraction back up into an over b 
style situation involves negative first powers and adding 1, two exceedingly simple operations (to add one add one to first integer in list).


 
Here's that same operation for negation, which isn't quite as simple. 

 17/12 = [ 1;2,2,2]   |  5/8  = [0;1,1,1,2]
-17/12 = [-2;1,1,2,2] | -5/8 = [-1;]



   x = [   a;b,   c,d,e,f,   etc.]
  -x = [-1-a;1,-1+b,c,d,e,f, etc.]
 
  
 100 = [100]
-100 = [-101;1,-1] = -100 

back-compatible!


 5/3 = [ 1;1,2]
-5/3 = [-2;1,0,2] = [-2; 3]

We can remove zeroes by, if they're in the middle, adding the numbers before and after it together. 

Some cool facts:

	All negative numbers can be written with totally positive numbers after the semicolon
	
	You don't want negative numbers after the semicolon, because they allow for infinitely many
	ways of writing zero, such as [1,-1], which makes deriving values more complex than it 
	needs to be.
	
	Some periodic infinite fractions with negative post-semicolon terms diverge, but all 
	positive ones don't

So we can pretty much ignore negatives. 


This gives unique representations, like decimal, pure integer representations for integers (as 
a list of integers with one integer in it), and lightweight representations of many widely used
numbers. 

Euler's identity gives us the trig expansion pack, at the expense of forcing us to use the general form, without unit numerators.



e^x =   1 +             x
			__________________________
			1 -             x
				______________________
				2+x-         2x
					 _________________
					 3+x-      3x
						  ____________
						  4+x-   ...
						  
log x = 1 +             x
			__________________________
			1 +             x
				______________________
				2-x+         4x
					 _________________
					 3-2x+      9x
						  ____________
						  4-3x+   ...
						 
With both numerators and denominators, we can write z^(m/n)	for any integer z,m,n as a periodic
continued fraction.					 

https://wikimedia.org/api/rest_v1/media/math/render/svg/68ca4eebd9f9f51d6a7ce01affd6e4288c645997

https://perl.plover.com/yak/cftalk/INFO/gosper.txt

https://pi.math.cornell.edu/~gautam/ContinuedFractions.pdf

All real numbers have some continued fraction, but ones like pi are random. 


1,2,5,12,29,70,169,408

2 cos(pi/5)

> inst :: Int -> Int
> inst r = ((1664525*r+1013904223) `mod` (2 ^ 32)) 

> lcg :: Int -> Int -> [Int]
> lcg ornd 1  = [(inst ornd)]
> lcg ornd it = do 
>   let nrnd = inst ornd 
>   (nrnd : lcg nrnd (it-1))

> sq :: Int -> Int
> sq n = sqrt2 0 n

> sqrt2 :: Int -> Int -> Int
> sqrt2 x y = if (x*x)>y then x-1 else sqrt2 (x+1) y

> isPrime :: Int -> Bool 
> isPrime p = if p `mod` 2 == 0 then False 
>               else isPrime2 p 3 (sq p) 

> isPrime2 :: Int -> Int -> Int -> Bool 
> isPrime2 p i n = if i>n  then True 
>   else if p `mod` i == 0 then False 
>                          else isPrime2 p (i+2) n

> nextPrime :: Int -> Int  
> nextPrime n = if isPrime n then n else nextPrime (n+1)

> prevPrime :: Int -> Int  
> prevPrime n = if isPrime n then n else prevPrime (n-1)

> tallyPrimesQuick :: Int -> [Int]
> tallyPrimesQuick n = if n<2 then [] 
>                     else if isPrime n 
>                       then n:(tallyPrimesQuick (n-1)) 
>                       else tallyPrimesQuick (n-1)

> coprime2 :: Int -> [Int] -> Bool
> coprime2 _ []     = True
> coprime2 a (p:ps) = if a `mod` p == 0 then False else coprime2 a ps

> cutoff :: Int -> [Int] -> [Int] 
> cutoff n []     = []
> cutoff n (a:as) = if n>a then [] else a:(cutoff n as)

> tallyPrimesSlow :: Int -> [Int]
> tallyPrimesSlow n = tallyPrimesSlow2 2 n []

> tallyPrimesSlow2 :: Int -> Int -> [Int] -> [Int]
> tallyPrimesSlow2 i n ps = if i>n then ps 
>                            else if coprime2 i (cutoff (sq i) ps) 
>                                   then tallyPrimesSlow2 (i+1) n (i:ps) 
>                                   else tallyPrimesSlow2 (i+1) n (ps)

-- With this I can confidently state

> primesto10000 :: [Int]
> primesto10000 = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,521,523,541,547,557,563,569,571,577,587,593,599,601,607,613,617,619,631,641,643,647,653,659,661,673,677,683,691,701,709,719,727,733,739,743,751,757,761,769,773,787,797,809,811,821,823,827,829,839,853,857,859,863,877,881,883,887,907,911,919,929,937,941,947,953,967,971,977,983,991,997,1009,1013,1019,1021,1031,1033,1039,1049,1051,1061,1063,1069,1087,1091,1093,1097,1103,1109,1117,1123,1129,1151,1153,1163,1171,1181,1187,1193,1201,1213,1217,1223,1229,1231,1237,1249,1259,1277,1279,1283,1289,1291,1297,1301,1303,1307,1319,1321,1327,1361,1367,1373,1381,1399,1409,1423,1427,1429,1433,1439,1447,1451,1453,1459,1471,1481,1483,1487,1489,1493,1499,1511,1523,1531,1543,1549,1553,1559,1567,1571,1579,1583,1597,1601,1607,1609,1613,1619,1621,1627,1637,1657,1663,1667,1669,1693,1697,1699,1709,1721,1723,1733,1741,1747,1753,1759,1777,1783,1787,1789,1801,1811,1823,1831,1847,1861,1867,1871,1873,1877,1879,1889,1901,1907,1913,1931,1933,1949,1951,1973,1979,1987,1993,1997,1999,2003,2011,2017,2027,2029,2039,2053,2063,2069,2081,2083,2087,2089,2099,2111,2113,2129,2131,2137,2141,2143,2153,2161,2179,2203,2207,2213,2221,2237,2239,2243,2251,2267,2269,2273,2281,2287,2293,2297,2309,2311,2333,2339,2341,2347,2351,2357,2371,2377,2381,2383,2389,2393,2399,2411,2417,2423,2437,2441,2447,2459,2467,2473,2477,2503,2521,2531,2539,2543,2549,2551,2557,2579,2591,2593,2609,2617,2621,2633,2647,2657,2659,2663,2671,2677,2683,2687,2689,2693,2699,2707,2711,2713,2719,2729,2731,2741,2749,2753,2767,2777,2789,2791,2797,2801,2803,2819,2833,2837,2843,2851,2857,2861,2879,2887,2897,2903,2909,2917,2927,2939,2953,2957,2963,2969,2971,2999,3001,3011,3019,3023,3037,3041,3049,3061,3067,3079,3083,3089,3109,3119,3121,3137,3163,3167,3169,3181,3187,3191,3203,3209,3217,3221,3229,3251,3253,3257,3259,3271,3299,3301,3307,3313,3319,3323,3329,3331,3343,3347,3359,3361,3371,3373,3389,3391,3407,3413,3433,3449,3457,3461,3463,3467,3469,3491,3499,3511,3517,3527,3529,3533,3539,3541,3547,3557,3559,3571,3581,3583,3593,3607,3613,3617,3623,3631,3637,3643,3659,3671,3673,3677,3691,3697,3701,3709,3719,3727,3733,3739,3761,3767,3769,3779,3793,3797,3803,3821,3823,3833,3847,3851,3853,3863,3877,3881,3889,3907,3911,3917,3919,3923,3929,3931,3943,3947,3967,3989,4001,4003,4007,4013,4019,4021,4027,4049,4051,4057,4073,4079,4091,4093,4099,4111,4127,4129,4133,4139,4153,4157,4159,4177,4201,4211,4217,4219,4229,4231,4241,4243,4253,4259,4261,4271,4273,4283,4289,4297,4327,4337,4339,4349,4357,4363,4373,4391,4397,4409,4421,4423,4441,4447,4451,4457,4463,4481,4483,4493,4507,4513,4517,4519,4523,4547,4549,4561,4567,4583,4591,4597,4603,4621,4637,4639,4643,4649,4651,4657,4663,4673,4679,4691,4703,4721,4723,4729,4733,4751,4759,4783,4787,4789,4793,4799,4801,4813,4817,4831,4861,4871,4877,4889,4903,4909,4919,4931,4933,4937,4943,4951,4957,4967,4969,4973,4987,4993,4999,5003,5009,5011,5021,5023,5039,5051,5059,5077,5081,5087,5099,5101,5107,5113,5119,5147,5153,5167,5171,5179,5189,5197,5209,5227,5231,5233,5237,5261,5273,5279,5281,5297,5303,5309,5323,5333,5347,5351,5381,5387,5393,5399,5407,5413,5417,5419,5431,5437,5441,5443,5449,5471,5477,5479,5483,5501,5503,5507,5519,5521,5527,5531,5557,5563,5569,5573,5581,5591,5623,5639,5641,5647,5651,5653,5657,5659,5669,5683,5689,5693,5701,5711,5717,5737,5741,5743,5749,5779,5783,5791,5801,5807,5813,5821,5827,5839,5843,5849,5851,5857,5861,5867,5869,5879,5881,5897,5903,5923,5927,5939,5953,5981,5987,6007,6011,6029,6037,6043,6047,6053,6067,6073,6079,6089,6091,6101,6113,6121,6131,6133,6143,6151,6163,6173,6197,6199,6203,6211,6217,6221,6229,6247,6257,6263,6269,6271,6277,6287,6299,6301,6311,6317,6323,6329,6337,6343,6353,6359,6361,6367,6373,6379,6389,6397,6421,6427,6449,6451,6469,6473,6481,6491,6521,6529,6547,6551,6553,6563,6569,6571,6577,6581,6599,6607,6619,6637,6653,6659,6661,6673,6679,6689,6691,6701,6703,6709,6719,6733,6737,6761,6763,6779,6781,6791,6793,6803,6823,6827,6829,6833,6841,6857,6863,6869,6871,6883,6899,6907,6911,6917,6947,6949,6959,6961,6967,6971,6977,6983,6991,6997,7001,7013,7019,7027,7039,7043,7057,7069,7079,7103,7109,7121,7127,7129,7151,7159,7177,7187,7193,7207,7211,7213,7219,7229,7237,7243,7247,7253,7283,7297,7307,7309,7321,7331,7333,7349,7351,7369,7393,7411,7417,7433,7451,7457,7459,7477,7481,7487,7489,7499,7507,7517,7523,7529,7537,7541,7547,7549,7559,7561,7573,7577,7583,7589,7591,7603,7607,7621,7639,7643,7649,7669,7673,7681,7687,7691,7699,7703,7717,7723,7727,7741,7753,7757,7759,7789,7793,7817,7823,7829,7841,7853,7867,7873,7877,7879,7883,7901,7907,7919,7927,7933,7937,7949,7951,7963,7993,8009,8011,8017,8039,8053,8059,8069,8081,8087,8089,8093,8101,8111,8117,8123,8147,8161,8167,8171,8179,8191,8209,8219,8221,8231,8233,8237,8243,8263,8269,8273,8287,8291,8293,8297,8311,8317,8329,8353,8363,8369,8377,8387,8389,8419,8423,8429,8431,8443,8447,8461,8467,8501,8513,8521,8527,8537,8539,8543,8563,8573,8581,8597,8599,8609,8623,8627,8629,8641,8647,8663,8669,8677,8681,8689,8693,8699,8707,8713,8719,8731,8737,8741,8747,8753,8761,8779,8783,8803,8807,8819,8821,8831,8837,8839,8849,8861,8863,8867,8887,8893,8923,8929,8933,8941,8951,8963,8969,8971,8999,9001,9007,9011,9013,9029,9041,9043,9049,9059,9067,9091,9103,9109,9127,9133,9137,9151,9157,9161,9173,9181,9187,9199,9203,9209,9221,9227,9239,9241,9257,9277,9281,9283,9293,9311,9319,9323,9337,9341,9343,9349,9371,9377,9391,9397,9403,9413,9419,9421,9431,9433,9437,9439,9461,9463,9467,9473,9479,9491,9497,9511,9521,9533,9539,9547,9551,9587,9601,9613,9619,9623,9629,9631,9643,9649,9661,9677,9679,9689,9697,9719,9721,9733,9739,9743,9749,9767,9769,9781,9787,9791,9803,9811,9817,9829,9833,9839,9851,9857,9859,9871,9883,9887,9901,9907,9923,9929,9931,9941,9949,9967,9973]


> pcf :: Int -> Int
> pcf a = if a<2 then 0 else if isPrime a then 1+(pcf (a-1)) else pcf (a-1)

-- mm.. quite slow, maybe that list could help.

> pcf1 :: Int -> Int
> pcf1 n = pcf2 n primesto10000

> pcf2 :: Int -> [Int] -> Int
> pcf2 n []     = pcf3 10000 n
> pcf2 n (p:ps) = if n<p then 0 else 1+(pcf2 n ps)

> pcf3 :: Int -> Int -> Int
> pcf3 i n = if i>n then 0 else if isPrime i then 1+(pcf3 (i+1) n) else pcf3 (i+1) n

ghci> totient 15000
1754
ghci> 15000 / (log 15000)
1559.931721899643

> gcd' :: Int -> Int -> Int
> gcd' a 0 = a 
> gcd' a b = gcd' b (a `mod` b)

> lcm' :: Int -> Int -> Int
> lcm' a b = (a*b) `div` (gcd' a b)

> primeFactors :: Int -> [Int]
> primeFactors a = factors2 a primesto10000

> factors2 :: Int -> [Int] -> [Int]
> factors2 a []     = []   
> factors2 a (p:ps) = if a<2 then [] 
>   else if isPrime a then [a] 
>   else do 
>     let (da,ma) = a `divMod` p
>     if ma == 0 then p:(factors2 da (p:ps))
>                else factors2 a ps

-- How they get factors in the user's guide (slower and not all prime):

> divisors :: Int -> [Int]
> divisors n = [d | d <- [1..(n `div` 2)], n `mod` d == 0]


> coprime :: Int -> Int -> Bool 
> coprime a b = if gcd a b == 1 then True else False

> totient :: Int -> Int 
> totient n = totient2 1 n

> totient2 :: Int -> Int -> Int 
> totient2 i n = if i>n then 0 
>           else if gcd i n == 1 
>                  then 1+(totient2 (i+1) n) 
>                  else    totient2 (i+1) n

> (%) :: Int -> Int -> Int
> a % b = a `mod` b

> (//) :: Int -> Int -> Int
> a // b = a `div` b

> (/%/) :: Int -> Int -> (Int, Int)
> a /%/ b = a `divMod` b

> (~) :: Int -> Int -> Int
> a ~ 0 = a
> 0 ~ b = b
> a ~ b = do
>   let (da,ma) = a /%/ 2
>   let (db,mb) = b /%/ 2
>   if ma == mb 
>     then    2*(da ~ db)
>     else 1+(2*(da ~ db))

> (&) :: Int -> Int -> Int
> a & 0 = a
> 0 & b = b
> a & b = do
>   let (da,ma) = a /%/ 2
>   let (db,mb) = b /%/ 2
>   if ma == mb && ma == 1
>     then 1+(2*(da & db))
>     else    2*(da & db)

> (#) :: Int -> Int -> Int
> a # 0 = a
> 0 # b = b
> a # b = do
>   let (da,ma) = a /%/ 2
>   let (db,mb) = b /%/ 2
>   if ma == mb && ma == 1
>     then 1+(2*(da # db))
>     else    2*(da # db)

> (?) :: Int -> Int -> [Int]
> n ? seed = lcg seed n

1
0 1
0 1 1
0 1 3  1
0 1 7  6  1
0 1 15 25 10 1

> stir :: Int -> Int -> Int
> stir n k =    if n==k then 1 
>   else if k==0 || k>n then 0 
>   else (k*(stir (n-1) k)) + (stir (n-1) (k-1)) 