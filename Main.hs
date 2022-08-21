module Main where

--TYPES
data BipWord = BipWord Int String

data BipList = [BipWord]

--List of shuffled indices
data BipOrder = [Int]


--BIP LIST/ORDERS

--Build a BipList from a file
fileToBipList :: IO () -> BipList

--Take an int, return a shuffled list of 2048 BIP39 keywords
shuffleBIP :: [Int] -> BipOrder


--TUI

--take a BipWord, BipList and BipOrder, return the Int of that Word
wordToInt :: BipWord -> BipList -> BipOrder -> Int

--take an Int, BipList and BipOrder, return the appropriate BipWord
intToWord :: Int -> BipList -> BipOrder -> BipWord

--Take a BIP list and a shuffle and turn to a 2x2 matrix
buildShuffle :: BipList -> BipOrder -> [[BipWord]]

--2x2 Matrix of BipWords and show on screen
displayShuffle:: [[BipWord]] -> IO ()


--SELECTING AND TOGGLING CELLS FOR INCLUSION

--Prompt for 12, 15, 24 word seed phrase

--Check for correct number of words

--EXPORTING

main :: IO ()
