module Main (Cell(Blank, X, O), Game, initialGame, takeTurn, play, main) where
-- Tic Tac Toe
-- ghc the_name_of_this_file.hs
-- the_name_of_this_file.exe

-- Define a tic-tac-toe board type

import qualified Data.Map as Map
import Data.List
-- analogous to import in Java

data Cell = Blank | X | O -- One of 3 possible cell types. it's sorta like an enum (e.g., enum { Blank, X, O })

instance Show Cell where -- sorta like implementing an interface, (e.g., Cell implements Show)
	show Blank = " "
	show X = "X"
	show O = "O"

-- Initialize board
initialBoard = Map.fromList [((i,j), Blank) | i <- [0..2], j <- [0..2]]

data Game = Game { -- sorta like a struct (e.g., struct Game { Cell[3][3] board; Cell player;})
	board :: Map.Map (Int, Int) Cell,
	player :: Cell
}

initialGame = Game initialBoard X

instance Show Game where -- sorta like implementing an interface, (e.g., Game implements Show)
	show Game { board=b, player=p } = "It's player " ++ show p ++ "'s turn\n" ++
		(foldl1 rows $ map (foldl1 cols . map show) $ unMap b)
	 where
	 	rows x y = x ++ "\n-----------\n" ++ y
	 	cols x y = x ++ " | " ++ y

unMap :: Map.Map (Int, Int) Cell -> [[Cell]]
unMap board = map (map snd) $ groupBy (\((i,j),_) ((k,l),_) -> i == k) $ Map.assocs board

takeTurn :: Game -> (Int, Int) -> Game
takeTurn game@Game { board=b, player=p } (i, j)
	| validMove b i j = newGame -- if we can make a valid move at row i, column j, then return the game state
	| otherwise = game -- otherwise, the game state doesn't change
 where
 	newGame = Game {
 		board = b, -- FIXME might want to use Map.adjust here to change the board,
 		player = p -- FIXME might want to switch the player if the player didn't just win.
	}

switch :: Cell -> Cell -- switch players: x becomes o, o becomes x
switch cell = Blank -- FIXME

validMove :: Map.Map (Int, Int) Cell -> Int -> Int -> Bool -- is the move valid?
-- well, when is a move invalid?
-- when the number is outside the bounds of the board
-- when the cell has already been played (it's not blank)
validMove board i j = False -- FIXME

diagonals :: Map.Map (Int, Int) Cell -> [[Cell]] -- get a list of diagonals
diagonals board = [[]] -- FIXME

winner :: Map.Map (Int, Int) Cell -> Bool -- is there a winner?
winner board = False -- FIXME

gameOver :: Map.Map (Int, Int) Cell -> Bool -- is the game over? either somebody won, or there's no blanks left
gameOver board = False -- FIXME

play :: Game -> IO Game
play game = do
	print game
	putStrLn "Make your move"
	row <- getChar
	getChar -- eat the space
	col <- getChar
	getLine -- eat the line
	let i = read (row:"")::Int
	let j = read (col:"")::Int
	let game' = takeTurn game (i,j)
	if not $ gameOver $ board $ game' then
		play game'
	else do
		print game'
		return (game')


main = play initialGame