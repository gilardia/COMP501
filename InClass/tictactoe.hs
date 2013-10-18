-- Tic Tac Toe
-- ghc the_name_of_this_file.hs
-- the_name_of_this_file.exe

-- Define a tic-tac-toe board type

data Cell = Blank | X | O -- One of 3 possible cell types. it's sorta like an enum (e.g., enum { Blank, X, O })

instance Show Cell where -- sorta like implementing an interface, (e.g., Cell implements Show)
	show Blank = " "
	show X = "X"
	show O = "O"

-- Initialize board
-- First attempt: initialBoard = [[Blank, Blank, Blank], [Blank, Blank, Blank], [Blank, Blank, Blank]]
initialBoard = [row, row, row] where row = take 3 $ repeat Blank -- this is just a constant to declare a blank board.

data Game = Game { -- sorta like a struct (e.g., struct Game { Cell[3][3] board; Cell player;})
	board :: [[Cell]],
	player :: Cell
}

instance Show Game where -- sorta like implementing an interface, (e.g., Game implements Show)
	show Game { board=b, player=p } = "It's player " ++ show p ++ "'s turn\n"

initialGame = Game initialBoard X

main = do -- pretty much our main function
	print initialGame