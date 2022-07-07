
import Control.Monad.Fix

saberq = 8192
saberqhalf = (saberq `div` 2)
q = 7681
qhalf = 3840
r = (2^16)

getRedBound :: Integer -> Integer
getRedBound x = (x `div` r) + qhalf + 2

getNextBound :: Integer -> Integer
getNextBound x = x + getRedBound (x * qhalf)

getNthBound :: Integer -> Integer -> Integer
getNthBound n x
    | n <= 0 = x
    | otherwise = getNthBound (n - 1) $ getNextBound x

-- getBigBound = 16771
-- logBase 2 (fromIntegral getBigBound) = 14.03368109421369
getBigBound = getNthBound 3 $ getRedBound $ getNthBound 3 saberqhalf

-- getSmallBound = 16771
-- logBase 2 (fromIntegral getSmallBound) = 14.03368109421369
getSmallBound = getNthBound 3 $ getRedBound $ getNthBound 3 5

accF :: Integer -> Integer -> Integer -> Integer
accF n c x
    | n == 0 = x
    | otherwise = accF (n - 1) c nx
        where nx = ( ((4 * getBigBound * getSmallBound + x * qhalf) `div` r) + qhalf + 2)

-- getBasemulBound = 22316
-- logBase 2 (fromIntegral getBasemulBound) = 14.445790836048078
getBasemulBound = accF 4 ( ((4 * getBigBound * getSmallBound) `div` r) + qhalf + 2) 0

-- getiNTTBound = 3842
-- logBase 2 (fromIntegral getiNTTBound) = 11.907641803665527
getiNTTBound = getRedBound $ getNthBound 4 $ getRedBound $ 4 * getBasemulBound



