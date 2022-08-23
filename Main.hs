import System.IO
import System.Random
import System.Random.Shuffle
import Control.Monad
import Bip


--TYPES
newtype BipWord  = BipWord String deriving (Eq, Show)
newtype BipList  = BipList [BipWord] deriving (Eq, Show)
newtype BipOrder = BipOrder [Int] deriving (Eq, Show)

--DATA
order :: BipOrder
order = BipOrder [1..2048]

--Take an Int, return a shuffled list of 2048 BIP39 keywords
shuffleBIP :: Int -> BipOrder -> BipOrder
shuffleBIP r (BipOrder idxs) = BipOrder $ shuffle' idxs 2048 (mkStdGen r)

--Take a [Int], apply them in order as seeds for shuffling a BipOrder
listShuffleBIP :: [Int] -> BipOrder -> BipOrder
listShuffleBIP []     bo = bo
listShuffleBIP (r:rs) bo = listShuffleBIP rs $ shuffleBIP r bo

--For future, load custom BIP list
loadBIP :: FilePath -> IO [String]
loadBIP path = do
    contents <- readFile path
    return (lines contents)


--TUI

--take a BipWord, BipList and BipOrder, return the Int of that Word
wordToInt :: BipWord -> BipList -> BipOrder -> Int
wordToInt = undefined

--take an Int, BipList and BipOrder, return the appropriate BipWord
intToWord :: Int -> BipList -> BipOrder -> BipWord
intToWord = undefined

--Take a BIP list and a shuffle and turn to a 2x2 matrix
buildShuffle :: BipList -> BipOrder -> [[BipWord]]
buildShuffle = undefined

--2x2 Matrix of BipWords and show on screen
displayShuffle :: [[BipWord]] -> IO ()
displayShuffle = undefined


--SELECTING AND TOGGLING CELLS FOR INCLUSION

--Prompt for 12, 15, 24 word seed phrase

--Check for correct number of words

--EXPORTING

main = do
    let order = BipOrder [1..2048]
    print order

    -- replace with get n
    let n = 0

    print $ shuffleBIP n order
