import System.IO
import System.Random
import System.Random.Shuffle
import Control.Monad
import Bip


{-
PROJECT SHEMATICS
1. Input a secret number to determine the randomness/shuffle of the BIPList
2. Input the number of words you'll need in the seed phrase 12, 13, 24.
3. Randomness is applied to the BIP39 List based on your secret number.
4. An interface that dispays the BIP Numbers on a 46 x 46 matrix.
5. You select an easy to remember pattern by clicking on the interface.
6. Each click records the number and outputs the seed word associated with that number
7. Your new generated words based on your memorable pattern becomes your private seed which you can use to create a wallet on any network.
-}


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

--Take a BIP list and a shuffle and turn to a 46x46 matrix that can contain the words on the List
buildShuffle :: BipList -> BipOrder -> [[BipWord]]
buildShuffle = undefined


--46x46 Matrix of BipWords and show on screen
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
