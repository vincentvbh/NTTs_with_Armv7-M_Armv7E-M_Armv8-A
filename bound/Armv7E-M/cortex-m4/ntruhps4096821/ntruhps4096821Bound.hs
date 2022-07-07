
import Control.Monad.Fix

ntruq = 4096
q = 6726529
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

-- getBigBound = 256531549
-- logBase 2 (fromIntegral getBigBound) = 27.93456102269696
getBigBound = getNthBound 4 $ 36 * (ntruq + 2 * getRedBound (ntruq * qhalf))

-- getSmallBound = 256383450
-- logBase 2 (fromIntegral getSmallBound) = 27.933727895573696
getSmallBound = getNthBound 4 $ 36 * (1 + 2 * getRedBound (1 * qhalf))

-- getBasemulBound = 49303390
-- logBase 2 (fromIntegral getBasemulBound) = 25.555183510977937
getBasemulBound = getRedBound $ 3 * getBigBound * getSmallBound

-- getiNTTBound = 242155152
-- logBase 2 (fromIntegral getiNTTBound) = 27.851356456590498
getiNTTBound = 2 * 36 * (getRedBound (8 * getBasemulBound))
