
import Control.Monad.Fix

ntruq = 5167
ntruqhalf = (ntruq `div` 2)
q = 8851393
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

-- getBigBound = 337789372
-- logBase 2 (fromIntegral getBigBound) = 28.331548695870215
getBigBound = getNthBound 4 $ 36 * (ntruqhalf + 2 * getRedBound (ntruqhalf * qhalf))

-- getSmallBound = 337695892
-- logBase 2 (fromIntegral getSmallBound) = 28.33114938846716
getSmallBound = getNthBound 4 $ 36 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 84102730
-- logBase 2 (fromIntegral getBasemulBound) = 26.325649295768503
getBasemulBound = getRedBound $ 3 * getBigBound * getSmallBound

-- getiNTTBound = 318650256
-- logBase 2 (fromIntegral getiNTTBound) = 28.247398578894252
getiNTTBound = 2 * 36 * (getRedBound (8 * getBasemulBound))


