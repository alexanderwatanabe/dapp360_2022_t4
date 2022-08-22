
import System.IO
import Control.Monad



--TYPES
data BipWord = BipWord String

--Build a BipList from a file
fileToBipList :: IO () -> [BipWord]
fileToBipList = undefined

--Take an int, return a shuffled list of 2048 BIP39 keywords
shuffleBIP :: [Int] -> [Int]
shuffleBIP = undefined

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
    contents <- readFile "bip39_english.txt"
    print . words $ contents