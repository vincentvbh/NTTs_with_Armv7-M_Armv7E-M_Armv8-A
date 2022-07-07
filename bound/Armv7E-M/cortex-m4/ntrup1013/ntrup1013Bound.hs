
import Control.Monad.Fix

q = 14533633
qhalf = (q `div` 2)
r = (2^32)

getRedBound :: Integer -> Integer
getRedBound x = (x `div` r) + qhalf + 2

getNextBound :: Integer -> Integer
getNextBound x = x + getRedBound (x * qhalf)

getNthBound :: Integer -> Integer -> Integer
getNthBound n x
    | n <= 0 = x
    | otherwise = getNthBound (n - 1) (getNextBound x)

-- getBigBound = 58483605
-- logBase 2 (fromIntegral getBigBound) = 25.80152890770647
getBigBound = getNthBound 8 3588

-- getSmallBound = 58479969
-- logBase 2 (fromIntegral getSmallBound) = 25.801439210735165
getSmallBound = getNthBound 8 1

-- getBasemulBound = 10452052
-- logBase 2 (fromIntegral getBasemulBound) = 23.317282871551523
getBasemulBound = getRedBound ( 4 * getBigBound * getSmallBound)

-- getiNTTBound = 694169803
-- logBase 2 (fromIntegral getiNTTBound) = 29.37071336712098
getiNTTBound = getNthBound 3 (64 * getBasemulBound)

