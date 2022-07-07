
import Control.Monad.Fix

saberq = 8192
saberqhalf = (saberq `div` 2)
q = 25570049
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

-- getBigBound = 77287460
-- logBase 2 (fromIntegral getBigBound) = 26.203731018032933
getBigBound = getNthBound 6 saberqhalf

-- getSmallBound = 77283296
-- logBase 2 (fromIntegral getSmallBound) = 26.20365328816595
getSmallBound = getNthBound 6 5

-- getBasemulBound = 18347843
-- logBase 2 (fromIntegral getBasemulBound) = 24.12910713185139
getBasemulBound = ( ((4 * getBigBound * getSmallBound) `div` r) + qhalf + 2)

-- getNewiNTTBound = 630859180
-- logBase 2 (fromIntegral getNewiNTTBound) = 29.232742762739953
getNewiNTTBound = getNthBound 3 $ getBasemulBound * 4 * 8






