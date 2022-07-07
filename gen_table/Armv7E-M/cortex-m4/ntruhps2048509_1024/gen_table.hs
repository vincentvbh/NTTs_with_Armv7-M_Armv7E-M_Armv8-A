
import CRT
import Tools

q = 2085121
pr = 7
nttn = 256
r = (2^32)

omega     = cmod ( pr^((q - 1) `div` nttn) ) q
invomega  = cmod (modularInv omega q) q
rmod      = cmod r q
qprime    = - (cmod (modularInv q r) r)
invn      = cmod (modularInv nttn q) q
invnrmod  = cmod (invn * rmod) q
invnr2mod = cmod (invnrmod * rmod) q

basicTable =
    [q, pr, omega, invomega, rmod, qprime,
     invn, invnrmod, invnr2mod]
basicTableSymbol =
    ["Q1", "Q1pr", "omegaQ1", "invomegaQ1", "RmodQ1", "Q1prime",
     "invNQ1", "invNRmodQ1", "invNR2modQ1"]

omega4        = cmod ( pr^((q - 1) `div` 4) ) q
invomega4     = cmod (modularInv omega4 q) q
omega4rmod    = cmod (omega4 * rmod) q
invomega4rmod = cmod (invomega4 * rmod) q

moreTables = []

moreTableSymbols = [""]

dictionary =
    zipWith (\x y -> (x, y)) (basicTableSymbol ++ moreTableSymbols) (basicTable ++ moreTables)
    ++
    [("omega4Q1", omega4), ("invomega4Q1", invomega4),
     ("omega4RmodQ1", omega4rmod), ("invomega4RmodQ1", invomega4rmod)
    ]

getIO = putStrLn $ concat $ map convertToDefines dictionary









