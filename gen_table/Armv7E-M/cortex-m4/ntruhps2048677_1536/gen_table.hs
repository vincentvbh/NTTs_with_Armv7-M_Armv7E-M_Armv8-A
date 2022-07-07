
import CRT
import Tools

q = 2773249
pr = 11
nttn = 128
r = (2^32)

omega     = cmod ( pr^((q - 1) `div` nttn) ) q
invomega  = cmod (modularInv omega q) q
rmod      = cmod r q
qprime    = - (cmod (modularInv q r) r)
invn      = cmod (modularInv (nttn * 3) q) q
invnrmod  = cmod (invn * rmod) q
invnr2mod = cmod (invnrmod * rmod) q

basicTable =
    [q, pr, omega, invomega, rmod, qprime,
     invn, invnrmod, invnr2mod]
basicTableSymbol =
    ["Q1", "Q1pr", "omegaQ1", "invomegaQ1", "RmodQ1", "Q1prime",
     "invNinv3Q1", "invNinv3RmodQ1", "invNinv3R2modQ1"]

omega3    = cmod ( pr^((q - 1) `div` 3) ) q
invomega3 = cmod (modularInv omega3 q) q

omega3rmod    = cmod (   omega3 * rmod) q
invomega3rmod = cmod (invomega3 * rmod) q

moreTables = []

moreTableSymbols = [""]

dictionary =
    zipWith (\x y -> (x, y)) (basicTableSymbol ++ moreTableSymbols) (basicTable ++ moreTables)
    ++
    [("omega3Q1", omega3), ("invomega3Q1", invomega3),
     ("omega3RmodQ1", omega3rmod), ("invomega3RmodQ1", invomega3rmod)
    ]


getIO = putStrLn $ concat $ map convertToDefines dictionary









