
module Tools
( cmod
, converToTable
, converToTableSymbol
, convertToDefines
) where

cmod :: Integral a => a -> a -> a
cmod a m
    | aMod > mHalf = aMod - m
    | aMod < -mHalf = aMod + m
    | otherwise = aMod
  where aMod = a `mod` m
        mHalf = m `div` 2

converToTable :: Integral a => a -> a -> [a] -> [a]
converToTable scale base xs = map ( ((*) scale) . ((^) base) ) xs

converToTableSymbol :: Integer -> String -> String -> String
converToTableSymbol x prefix suffix
    | x == 1 = prefix ++ suffix
    | otherwise = prefix ++ show(x) ++ suffix

convertToDefines :: (String, Integer) -> String
convertToDefines (s, a) = "#define " ++ s ++ " (" ++ show(a) ++ ")\n"


