
import CRT
import Tools

q = 6030433
pr = 5
nttn = 32
r = (2^32)

omega     = cmod ( pr^((q - 1) `div` nttn) ) q
invomega  = cmod (modularInv omega q) q
rmod      = cmod r q
qprime    = - (cmod (modularInv q r) r)
invn      = cmod (modularInv (nttn * 9) q) q
invnrmod  = cmod (invn * rmod) q
invnr2mod = cmod (invnrmod * rmod) q

basicTable =
    [q, pr, omega, invomega, rmod, qprime,
     invn, invnrmod, invnr2mod]
basicTableSymbol =
    ["Q1", "Q1pr", "omegaQ1", "invomegaQ1", "RmodQ1", "Q1prime",
     "invNinv9Q1", "invNinv9RmodQ1", "invNinv9R2modQ1"]

omega9    = cmod ( pr^((q - 1) `div` 9) ) q
invomega9 = cmod (modularInv omega9 q) q

omega4    = cmod ( pr^((q - 1) `div` 4) ) q
invomega4 = cmod (modularInv omega4 q) q

omega4rmod    = cmod (   omega4 * rmod) q
invomega4rmod = cmod (invomega4 * rmod) q

omega9Table        = map (\x -> cmod x q) (converToTable                 1     omega9 [1 .. 8])

omega9RmodTable    = map (\x -> cmod x q) (converToTable              rmod     omega9 [1 .. 8])
invomega9RmodTable = map (\x -> cmod x q) (converToTable              rmod  invomega9 [1 .. 8])
twistRmodTable     = map (\x -> cmod x q) (converToTable    (omega4 * rmod)    omega9 [1 .. 8])
invTwistRmodTable  = map (\x -> cmod x q) (converToTable (invomega4 * rmod) invomega9 [1 .. 8])

moreTables = omega9Table
    ++ omega9RmodTable ++ invomega9RmodTable
    ++ twistRmodTable ++ invTwistRmodTable

omega9TableSymbol        = map (\x -> converToTableSymbol x          "omega9"     "Q1") [1 .. 8]

omega9RmodTableSymbol    = map (\x -> converToTableSymbol x          "omega9" "RmodQ1") [1 .. 8]
invomega9RmodTableSymbol = map (\x -> converToTableSymbol x       "invomega9" "RmodQ1") [1 .. 8]
twistRmodTableSymbol     = map (\x -> converToTableSymbol x    "omega4omega9" "RmodQ1") [1 .. 8]
invTwistRmodTableSymbol  = map (\x -> converToTableSymbol x "invomega4omega9" "RmodQ1") [1 .. 8]

moreTableSymbols = omega9TableSymbol
    ++ omega9RmodTableSymbol ++ invomega9RmodTableSymbol
    ++ twistRmodTableSymbol ++ invTwistRmodTableSymbol

dictionary =
    zipWith (\x y -> (x, y)) (basicTableSymbol ++ moreTableSymbols) (basicTable ++ moreTables)
    ++
    [("omega4Q1", omega4), ("invomega4Q1", invomega4),
     ("omega4RmodQ1", omega4rmod), ("invomega4RmodQ1", invomega4rmod)
    ]


getIO = putStrLn $ concat $ map convertToDefines dictionary









