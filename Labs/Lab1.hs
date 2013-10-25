import Data.List
import Data.Maybe
import Data.Char

-- Find the last element in the list.
-- Fix the syntax error so that myLast [1 .. 6] returns 6
-- Note: I won't accept myLast = last
--myLast :: [a] -> a
myLast [x] = x
myLast (_:xs) = myLast xs

-- Return whether the list is a palindrome
-- Fix the error so that isPalindrome "tacocat" is true
--isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == reverse xs

-- Hailstone sequence
-- http://en.wikipedia.org/wiki/Hailstone_sequence
-- Write a program that computes the hailstone sequence for a given number
-- For example, hailstone 5 -> [5 16 8 4 2 1]
--hailstone :: Integer -> [Integer]

a `plus` b = a+b

f n
    | n `mod` 2 == 0 = n `div` 2
    | otherwise = 3*n+1

hailstone 1 = [1] -- base case (we hope)
hailstone n = n:hailstone (f n)

-- Write a function to convert a number into a list of digits
-- For example, toDigits 30 -> [3, 0]
--unpack :: Integer -> [Integer]

convertit n = (fromEnum n) - 48

unpack n = map convertit (show n)

{-
-- Also works
unpack n = map convertit (x:xs)
	where (x:xs) = (show n)
-}

-- Write a function to convert a list of digits into a number
-- For example, fromDigits [3, 4, 5] -> 345
--pack :: [Integer] -> Integer


-- Kaprekar's routine: 
-- http://en.wikipedia.org/wiki/6174_%28number%29
-- 1. Arrange the digits in ascending order
-- 2. Arrange the digits in descending order
-- Subtract the smaller number from the larger number
-- For example, kaprekar 5432 -> 3087
-- you will need to import Data.List (just put import Data.List on top of the file) for sort and reverse
-- For example, sort [ 1, 2, 5, 4] -> [1, 2, 4, 5]
-- reverse [1, 3, 4] -> [4, 3, 1]
--kaprekar :: Integer -> Integer


-- Kaprekar's list
-- Write a function that computes Kaprekar's routine for a number repeatedly until it reaches its fixed point
-- For example, kaprekarList 5432 -> [5432, 3087, 8352, 6174]
--kaprekarList :: Integer -> [Integer]

-- Spelling alphabet
-- Translate a string into a string spelled out using the NATO phonetic alphabet
-- http://en.wikipedia.org/wiki/NATO_phonetic_alphabet
-- For example, say "Fearing" -> "Foxtrot Echo Alpha Romeo India November Golf"
--say :: String -> String

toNATO x = fromJust (lookup x nato)
	where nato = zip ['a'..'z'] ["Alfa", "Bravo","Charlie", "Delta", "Echo", "Foxtrot"]

say string = map toLower (unwords (map (toNATO . toLower) string))

-- convert to separate characters
-- Haskell Strings are [Char]
-- have the array ready (it should be hard coded)
-- join everything back together into a string
