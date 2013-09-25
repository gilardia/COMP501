-- Functions to do more interesting stuff

-- Listing out the parameters
myOtherSum list = foldl (+) 0 list

-- Partially applying a function
-- Point-free style
mySum = foldl (+) 0

myEven = map (*2) [0..]
myLast list = head (reverse list)

-- Point-free (not pointless!)
myLast' = head . reverse

plus = (+)

-- 2 `plus` 2
-- define using lambdas
plus' = \x y -> x + y

plus'' x y = x + y

myLength list = foldl (+) 0 something -- something defined as local variable in where clause
	where something = map (\x -> 1) list -- where clause allows us to define local variable something

length' list = let something = map (\x -> 1) list
	in foldl (+) 0 something
