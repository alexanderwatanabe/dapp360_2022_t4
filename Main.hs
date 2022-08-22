
import System.IO
import System.Random
import System.Random.Shuffle
import Control.Monad
import Bip
import Data.Char (ord)
import Data.Map.Internal.Debug (ordered)


--TYPES
data BipWord     = BipWord String deriving (Eq, Show)
data BipList     = BipList Int [BipWord] deriving (Eq, Show)
data BipOrder    = BipOrder Int [Int] deriving (Eq, Show)


--Take an int, return a shuffled list of 2048 BIP39 keywords
shuffleBIP :: Int -> BipOrder -> BipOrder
shuffleBIP r (BipOrder n idxs) = BipOrder n $ shuffle' idxs n (mkStdGen r)

loadBIP :: FilePath -> IO [String]
loadBIP path = do
    contents <- readFile path
    return (lines contents)


--TUI

--take a BipWord, BipList and BipOrder, return the Int of that Word
wordToInt :: BipWord -> [BipWord] -> [Int] -> Int
wordToInt = undefined

--take an Int, BipList and BipOrder, return the appropriate BipWord
intToWord :: Int -> [BipWord] -> [Int] -> BipWord
intToWord = undefined

--Take a BIP list and a shuffle and turn to a 2x2 matrix
buildShuffle :: [BipWord] -> [Int] -> [[BipWord]]
buildShuffle = undefined

--2x2 Matrix of BipWords and show on screen
displayShuffle :: [[BipWord]] -> IO ()
displayShuffle = undefined


--SELECTING AND TOGGLING CELLS FOR INCLUSION

--Prompt for 12, 15, 24 word seed phrase

--Check for correct number of words

--EXPORTING

main = do
    let order = BipOrder 2048 [1..2048]
    print order

    -- replace with get n
    let n = 0

    print $ shuffleBIP n order
