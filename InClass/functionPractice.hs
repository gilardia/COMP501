-- Practice problems

-- Here's one way to write sum
sum' list = foldl (+) 0 list

-- Write these functions.
-- max' :: [Integer] -> Integer
max' list = foldl max (head list) list

max'' [x] = x
max'' (x:xs)
    | x > maxTail = x      -- Guard (if then else)
    | otherwise = maxTail
    where maxTail = max'' xs

max''' [x] = x -- if we have a list with a single element, return that element
max''' (x:xs) = if x > maxTail
    then x
    else maxTail
    where maxTail = max''' xs

max'''' [x] = x
max'''' (x:xs) = let maxTail = max'''' xs
    in
    if x > maxTail then x
        else maxTail

-- min' :: [Integer] -> Integer

-- average :: [Integer] -> Double
average list = fromIntegral (sum list) / fromIntegral (length list)