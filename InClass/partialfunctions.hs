-- In Class activity

-- Given a number, add the number to itself
-- E.g., times_two 2 should produce 4
times_two :: Num a => a -> a
--times_two = (* 2) -- Partially applying multiply function
-- times_two a = a * 2 -- Given input, and we apply it
times_two = square (+)

operator_two f x y = f x (f x y)

-- Given a list, concatenate the list with itself
-- E.g., dup [1,2,3] should produce [1,2,3,1,2,3]
dup :: [a] -> [a]
dup = square (++) -- List concatenation

-- Create a function called square
-- Given a function that takes two inputs, and a single value, it applies
-- the function on that value twice.
-- E.g., we could re-implement dup above as dup = square (++)
-- E.g., we could implement times_two as times_two = square (+)
-- E.g., square (\x y -> x - y) 2 gives 0.
square :: (a -> a -> b) -> a -> b
square f a = f a a

second :: [a] -> a
second xs     = head (tail xs)

swap :: (a,b) -> (b,a)
swap (x,y)    = (y,x)

pair :: a -> b -> (a,b)
pair x y      = (x,y)

double x      = x*2

twice f x     = f (f x)
