-- Starter code from: http://www.animal-machine.com/blog/2010/04/getting-started-with-sdl-in-haskell/

import Graphics.UI.SDL as SDL

main :: IO()
main = do
	SDL.init [SDL.InitEverything]
	SDL.setVideoMode 640 480 32 []
	SDL.setCaption "Video test!" "video test"
	eventLoop
	SDL.quit
	print "done"
 where
	eventLoop = SDL.waitEventBlocking >>= checkEvent
	checkEvent (KeyUp _) = return ()
	checkEvent _         = eventLoop
