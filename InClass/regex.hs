module Main (main, Regex(Reject,Empty,Symbol,Or,Seq,Star), nullable, derive, match) where

data Regex = Reject | Empty | Symbol Char | Or Regex Regex | Seq Regex Regex | Star Regex

nullable :: Regex -> Bool
nullable Reject = False
nullable Empty = True
nullable (Symbol c) = False
nullable (Or a b) = (nullable a) || (nullable b)
nullable (Seq a b) = (nullable a) && (nullable b)
nullable (Star a) = True

derive :: Regex -> Char -> Regex
derive Reject _ = Reject
derive Empty _ = Reject
derive (Symbol c) char
	| c == char = Empty
	| otherwise = Reject
derive (Or a b) c = Or (derive a c) (derive b c)
derive (Seq a b) c
	| nullable a = Or regex $ derive b c
	| otherwise = regex
 where regex = Seq (derive a c) b
derive star@(Star a) c = Seq (derive a c) star

match :: Regex -> String -> Bool
match regex string = nullable $ foldl derive regex string

main = putStr "hi"