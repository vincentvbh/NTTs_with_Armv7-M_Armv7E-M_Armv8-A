
import Control.Monad.Fix

ntruq = 2048
q = 2773153
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

-- getBigBound = 20828432
-- logBase 2 (fromIntegral getBigBound) = 24.312050899126767
getBigBound = getNthBound 3 $ 6 * (ntruq + 2 * getRedBound (ntruq * qhalf))

-- getSmallBound = 20816138
-- logBase 2 (fromIntegral getSmallBound) = 24.311199095717686
getSmallBound = getNthBound 3 $ 6 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 1891317
-- logBase 2 (fromIntegral getBasemulBound) = 20.850959760215954
getBasemulBound = getRedBound $ 5 * getBigBound * getSmallBound

-- getiNTTBound = 72314452
-- logBase 2 (fromIntegral getiNTTBound) = 26.107780661943657
getiNTTBound = getNthBound 3 $ 36 * getBasemulBound
