# Haskell Background

## Import stuff

In WinGHCi, typ in this to import list functions:

	import Data.List

## Lists and list functions
In WinGHCi, type in the following, line by line, to see what you get. What's going on with each of these commands?

	[1..5]
	[5,4..1]
	[0,5..100]
	[1..] -- press Ctrl-C to stop
	head [1..5]
	tail [1..5]
	init [1..5]
	last [1..5]
	[1..5] !! 0
	[0,5..100] !! 2
	take 3 [1..5]
	drop 3 [1..5]
	length [1..5]
	sum [1..5]
	product [1..5]
	[1,2,3] ++ [4,5]
	reverse [1..5]
	['a'..'z'] ++ ['A'..'Z']
	sort "the quick brown fox jumps over the lazy dog"

## Types

`:t` displays the type of anything you give to it. Type in the following in GHCi, line by line to see what you get:

	:t [1..5]
	:t "hello"
	:t sort
	:t length
	:t sum
	:t head

What do you notice about the types for data and functions?

## Functions

In WinGHCi, open up the factorial.hs file. Can you write function `fibonacci :: Integer -> Integer`? Save it in factorial.hs and reload it. Then try the following:

	map factorial [1..10]
	map fibonacci [1..10]

