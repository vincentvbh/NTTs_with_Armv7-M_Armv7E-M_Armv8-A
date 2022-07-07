
import Control.Monad.Fix

ntruq = 4591
ntruqhalf = (ntruq `div` 2)
q = 6984193
qhalf = (q `div` 2)
r = (2^32)

getRedBound :: Integer -> Integer
getRedBound x = (x `div` r) + qhalf + 2

getNextBound :: Integer -> Integer
getNextBound x = x + getRedBound (x * qhalf)

getNthBound :: Integer -> Integer -> Integer
getNthBound n x
    | n <= 0 = x
    | otherwise = getNthBound (n - 1) $ getNextBound x

-- getBigBound = 66531644
-- logBase 2 (fromIntegral getBigBound) = 25.987537347433218
getBigBound = getNthBound 3 $ 8 * (ntruq + 2 * getRedBound (ntruq * qhalf))

-- getSmallBound = 66494786
-- logBase 2 (fromIntegral getSmallBound) = 25.98673788442158
getSmallBound = getNthBound 3 $ 8 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 7612275
-- logBase 2 (fromIntegral getBasemulBound) = 22.85989625048023
getBasemulBound = getRedBound $ 4 * getBigBound * getSmallBound

-- getiNTTBound = 376765995
-- logBase 2 (fromIntegral getiNTTBound) = 28.489093519541367
getiNTTBound = getNthBound 3 $ 8 * 6 * getBasemulBound
