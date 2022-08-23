{-# LANGUAGE OverloadedStrings #-}

import System.IO
import System.Random
import System.Random.Shuffle
import Control.Monad
import Brick
import Brick.Widgets.Table
import Brick.Widgets.Center (center)
import Bip



--TYPES
newtype BipList  = BipList [(Int, String)] deriving (Eq, Show)

--DATA
bip39 :: BipList
bip39 = BipList $ zip [1..2048] bip39words

--For future, load custom BIP list
loadBIP :: FilePath -> IO [String]
loadBIP path = do
    contents <- readFile path
    return (lines contents)


--RNG

--Take an Int, return a shuffled list of 2048 BIP39 keywords
shuffleBIP :: Int -> BipList -> BipList
shuffleBIP r (BipList bl) =  BipList $ shuffle' bl 2048 (mkStdGen r)

--Take a [Int], apply them in order as seeds for shuffling a BipOrder
listShuffleBIP :: [Int] -> BipList -> BipList
listShuffleBIP []     bl = bl
listShuffleBIP (r:rs) bl = listShuffleBIP rs $ shuffleBIP r bl

--2x2 Matrix of BipWords and show on screen
twoByTwoBIP :: BipList -> [[(Int, String)]]
twoByTwoBIP (BipList []) = [[(0,"")]]
twoByTwoBIP (BipList bl) = (take 46 bl) : (twoByTwoBIP $ (BipList (drop 46 bl)))


--RECOVER SEED PHRASE

--verify correct number of Bools in mask
validatePattern :: Int -> [[Bool]] -> Bool
validatePattern n bools = undefined

--take a list of BIP words (eg ["absurd", "accident"]) and a 46x46 array of Bools (which )
recover :: [String] -> [[Bool]] -> [String]
recover (w:ws) bools = undefined


--TUI

--SELECTING AND TOGGLING CELLS FOR INCLUSION

--Prompt for 12, 15, 24 word seed phrase
--Check for correct number of words

fakeTableData :: [[Widget ()]]
fakeTableData = [ [txt "a", txt "b", txt "c"]
                , [txt "d", txt "e", txt "f"]
                , [txt "g", txt "h", txt "i"]
                ]

fakeTableData' :: [[Widget ()]]
fakeTableData' = map txt twoByTwoBIP bip39

t :: Table ()
t =
    surroundingBorder True $
    table fakeTableData

ui :: Widget ()
ui = center $ renderTable t

main = do
    simpleMain ui