
import Control.Monad.Fix

ntruq = 2048
q = 2773249
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

-- getBigBound = 26385131
-- logBase 2 (fromIntegral getBigBound) = 24.653221810622277
getBigBound = getNthBound 3 $ 8 * (ntruq + 2 * getRedBound (ntruq * qhalf))

-- getSmallBound = 26368738
-- logBase 2 (fromIntegral getSmallBound) = 24.652325190108378
getSmallBound = getNthBound 3 $ 8 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 2034586
-- logBase 2 (fromIntegral getBasemulBound) = 20.95630383236115
getBasemulBound = getRedBound $ 4 * getBigBound * getSmallBound

-- getiNTTBound = 101915967
-- logBase 2 (fromIntegral getiNTTBound) = 26.602804852871092
getiNTTBound = getNthBound 3 $ 8 * 6 * getBasemulBound
