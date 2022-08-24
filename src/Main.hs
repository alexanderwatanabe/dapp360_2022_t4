{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.IO ()
import System.Random ( mkStdGen )
import System.Random.Shuffle ( shuffle' )
import Control.Monad ()
import Brick ( simpleMain, txt, Widget )
import Brick.Widgets.Table
    ( renderTable, surroundingBorder, table, Table )
import Brick.Widgets.Center (center)
import Bip ( bip39words )
import qualified Data.Text as T



--TYPES
newtype BipList  = BipList [(Int, String)] deriving (Eq, Show)


--DATA
bip39 :: BipList
bip39 = BipList $ zip [0..2047] bip39words


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
listShuffleBIP rs bl = foldl (flip shuffleBIP) bl rs

--46x46 Matrix of BipWords and show on screen
twoByTwoBIP :: BipList -> [[(Int, String)]]
twoByTwoBIP (BipList []) = []
twoByTwoBIP (BipList bl) = take 46 bl : (twoByTwoBIP $ BipList (drop 46 bl))


--RECOVER SEED PHRASE

--verify correct number of Bools in mask
validatePattern :: Int -> [[Bool]] -> Bool
validatePattern n bools = undefined

--take a list of BIP words (eg ["absurd", "accident"]) and a 46x46 array of Bools (which )
recover :: [String] -> [[Bool]] -> [String]
recover (w:ws) bools = undefined


--TUI

textifyNestedList :: Show a => [[a]] -> [[T.Text]]
textifyNestedList = map ( map (T.pack . show) )

widgetizeNestedList :: [[T.Text]] -> [[Widget ()]]
widgetizeNestedList = map ( map txt )

--Take a list of Ints
twoDify :: [Int] -> [[Int]]
twoDify []     = []
twoDify (x:xs) = map (+ x) [0..45] : twoDify xs

--Take Locations, a 2D BIPList and return the ind
getIndices :: [(Int, Int)] -> [[(Int, String)]] -> [Int]
getIndices []             m = []
getIndices ((x,y) : xys ) m = (fst $ (m !! y) !! x) : getIndices xys m

--getIndices pattern1 $ twoByTwoBIP bip39



--SELECTING AND TOGGLING CELLS FOR INCLUSION

--Prompt for 12, 15, 24 word seed phrase

--Check that selected word patterns does not exceed chosen prompt.

--output to 46x46 interface
t :: Table ()
t =
    surroundingBorder False $
    table . widgetizeNestedList . textifyNestedList $ twoDify [0,46..2048]

ui :: Widget ()
ui = center $ renderTable t

main = do
    simpleMain ui
