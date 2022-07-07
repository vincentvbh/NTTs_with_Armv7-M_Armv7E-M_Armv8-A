
import Control.Monad.Fix

ntruq = 4621
ntruqhalf = (ntruq `div` 2)
q = 6030433
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

-- getBigBound = 45324779
-- logBase 2 (fromIntegral getBigBound) = 25.4337966497324
getBigBound = getNthBound 3 $ 6 * (ntruqhalf + 2 * getRedBound (ntruqhalf * qhalf))

-- getSmallBound = 45310885
-- logBase 2 (fromIntegral getSmallBound) = 25.433354333668934
getSmallBound = getNthBound 3 $ 6 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 5406046
-- logBase 2 (fromIntegral getBasemulBound) = 22.366142357128993
getBasemulBound = getRedBound $ 5 * getBigBound * getSmallBound

-- getiNTTBound = 204079834
-- logBase 2 (fromIntegral getiNTTBound) = 27.60455838965391
getiNTTBound = getNthBound 3 $ 36 * getBasemulBound
