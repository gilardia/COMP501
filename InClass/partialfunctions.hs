-- In Class activity

-- Given a list, concatenate the list with itself
-- E.g., dup [1,2,3] should produce [1,2,3,1,2,3]
dup :: [a] -> [a]

-- Given a number, add the number to itself
-- E.g., times_two 2 should produce 4
times_two :: Num a => a -> a

-- Create a function called square
-- Given a function that takes two inputs, and a single value, it applies
-- the function on an that value twice.
-- E.g., we could re-implement dup above as dup = square (++)
square :: (a -> a -> b) -> a -> b
