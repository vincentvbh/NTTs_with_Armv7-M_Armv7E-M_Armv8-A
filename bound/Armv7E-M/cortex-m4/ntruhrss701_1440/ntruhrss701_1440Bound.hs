
import Control.Monad.Fix

ntruq = 8192
q = 11485729
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

-- getBigBound = 86492315
-- logBase 2 (fromIntegral getBigBound) = 26.36606861656865
getBigBound = getNthBound 3 $ 6 * (ntruq + 2 * getRedBound (ntruq * qhalf))

-- getSmallBound = 86442851
-- logBase 2 (fromIntegral getSmallBound) = 26.36524331919161
getSmallBound = getNthBound 3 $ 6 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 14446823
-- logBase 2 (fromIntegral getBasemulBound) = 23.784248928835055
getBasemulBound = getRedBound $ 5 * getBigBound * getSmallBound

-- getiNTTBound = 539426305
-- logBase 2 (fromIntegral getiNTTBound) = 29.006850635080504
getiNTTBound = getNthBound 3 $ 36 * getBasemulBound
