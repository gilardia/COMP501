module Main (Cell(Blank, X, O), Game, switch, board, player, initialGame, takeTurn, play, main) where
-- Tic Tac Toe
-- ghc the_name_of_this_file.hs
-- the_name_of_this_file.exe

-- Define a tic-tac-toe board type

import Graphics.UI.SDL
--import Graphics.UI.SDL.Image
import qualified Data.Map as Map
import Data.List
-- analogous to import in Java

data Cell = Blank | X | O deriving (Eq, Ord) -- One of 3 possible cell types. it's sorta like an enum (e.g., enum { Blank, X, O })

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
 		board = Map.adjust (\_ -> p) (i,j) b, -- FIXME might want to use Map.adjust here to change the board,
 		player = switch p -- FIXME might want to switch the player if the player didn't just win.
	}

switch :: Cell -> Cell -- switch players: x becomes o, o becomes x
switch O = X -- FIXME
switch X = O

validMove :: Map.Map (Int, Int) Cell -> Int -> Int -> Bool -- is the move valid?
-- well, when is a move invalid?
-- when the number is outside the bounds of the board
-- when the cell has already been played (it's not blank)
validMove board i j
	| i < 0 || i >= 3 = False
	| j < 0 || j >= 3 = False
	| otherwise = Blank == board Map.! (i,j)

diagonals :: Map.Map (Int, Int) Cell -> [[Cell]] -- get a list of diagonals
diagonals board = [[board Map.! (0,0), board Map.! (1,1), board Map.! (2,2)],
[board Map.! (2,0), board Map.! (1,1), board Map.! (0,2)]] -- FIXME

-- convert the board into lists of lists, and call the map function
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

loadImage :: String -> IO Surface
loadImage filename = loadBMP filename >>= displayFormat

applySurface :: Int -> Int -> Surface -> Surface -> IO Bool
applySurface x y src dst = blitSurface src Nothing dst offset
 where offset = Just Rect { rectX = x, rectY = y, rectW = 0, rectH = 0 }

-- main = play initialGame
display :: Game -> Surface -> IO Bool
display game@(Game board player) screen = do
	sequence_ $ Map.elems $ Map.mapWithKey displayCell board
	Graphics.UI.SDL.flip screen -- where the actual draw happens
	return True
	where
		-- cellSurface is a lookup table from Cell -> IO Surface
		cellSurface = Map.fromList [(O, loadImage "O.bmp"), (X, loadImage "X.bmp"), (Blank, loadImage "_.bmp")]
		displayCell (i,j) cell = do
			cs <- cellSurface Map.! cell
			applySurface (i*160) (j*160) (cs) screen

handleMouse :: Event -> Game -> Game
handleMouse (MouseButtonDown x y ButtonLeft) game = 
	takeTurn game (i, j)
 where i = fromIntegral $ x `quot` 160
       j = fromIntegral $ y `quot` 160

-- don't care about the other events
handleMouse _ game = game

loop game screen = do
	display game screen
	event <- pollEvent
	case event of
		Quit -> return True
		_ -> do 
			let game' = handleMouse event game
			if not $ gameOver $ board $ game' then
				loop game' screen
			else do
				display game' screen
				delay 2000
				return True

main = withInit [InitEverything] $ do

	screen <- setVideoMode screenWidth screenHeight screenBpp [SWSurface]
	setCaption "Tic-Tac-Toe" []

	loop initialGame screen
 where
 	screenWidth = 640
 	screenHeight = 480
 	screenBpp = 32
