--sum2 :: [Integer] -> Integer
-- Pattern matching approach (typical approach)
sum2 [] = error "You can't sum an empty list, silly!"
sum2 [x] = x  -- base case
sum2 (x:xs) = x + sum2 xs -- recursive case

-- dorky if expression approach
sum3 list = if length list == 0
	then error "You can't sum an empty list, silly!"
	else if length list == 1 -- base case
		then head list --base case
		else head list + sum3 (tail list)

-- super awesome approach
dimsum list = foldl (+) 0 list
dimsum2 list = foldl (\x y -> x + y) 0 list -- using a lambda expression

-- super duper awesome (point-free) approach
dimsum3 = foldl (+) 0

-- write out myLength with the super awesome approach
myLength :: [a] -> Integer
myLength list = foldl (+) 0 something -- something defined as local variable in where clause
	where something = map (\x -> 1) list -- where clause allows us to define local variable something

myLength2 list = sum (map (\x -> 1) list)

myLength3 list = foldl (\x y -> x + 1) 0 list -- here we're throwing away y and just adding 1 to x during the reduction (left fold)

-- Not haskell follows
-- sum [2,6,43,4576]

-- sum x<-2 xs<-[6,43,4576] = 2 + 6 + (43+4576)
-- sum x<-6 xs<-[43, 4576] = 6 + (43+4576)
-- sum x<-43 xs<-[4576] = 43 + 4576
-- sum x<-4576 = 4576