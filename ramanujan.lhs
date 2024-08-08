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

