
module CRT
( extendedEuclidean
, modularInv
, constructMults
, getCRTCoordinate
, getCRTV
) where

extendedEuclidean :: Integral a => a -> a -> (a, a, a)
extendedEuclidean 0 b = (b, 0, 1)
extendedEuclidean a b = (g, t - (b `div` a) * s, s)
                   where (g, s, t) = extendedEuclidean (b `mod` a) a

modularInv :: Integral a => a -> a -> a
modularInv a m
    | a < 0 = -(modularInv (-a) m)
    | otherwise = let (_, i, _) = extendedEuclidean a m in i `mod` m

constructMults :: Integral a => [a] -> a -> [a]
constructMults coprimeFactors modulus =
    map (\x -> ( (modulus `div` x) * (modularInv (modulus `div` x) x ) ) `mod` modulus) coprimeFactors

getCRTCoordinate :: Integral a => a -> [a] -> [a]
getCRTCoordinate a x = map (mod a) x

getCRTV :: Integral a => [a] -> [a] -> a -> a
getCRTV coordinates multiplicands modulus =
    mod (sum ( zipWith (*) coordinates multiplicands ) ) modulus


