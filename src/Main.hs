{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.IO ()
import System.Random ( mkStdGen )
import System.Random.Shuffle ( shuffle' )
import Control.Monad (replicateM_)
import Bip ( bip39words )
import System.Console.ANSI


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

--2x2 Matrix of BipWords and show on screen
twoByTwoBIP :: BipList -> [[(Int, String)]]
twoByTwoBIP (BipList []) = []
twoByTwoBIP (BipList bl) = take 46 bl : (twoByTwoBIP $ BipList (drop 46 bl))

twoByTwoWords :: [a] -> [[a]]
twoByTwoWords [] = []
twoByTwoWords ws = take 46 ws : (twoByTwoWords $ (drop 46 ws))


--RECOVER SEED PHRASE

--verify correct number of Bools in mask
validatePattern :: Int -> [[Bool]] -> Bool
validatePattern n bools = undefined

--verify provided words are in BIP39 list
validateWords :: [String] -> [Bool]
validateWords = undefined

--take a list of BIP words (eg ["absurd", "accident"]) and a 46x46 array of Bools (which )
recover :: [String] -> [[Bool]] -> [String]
recover (w:ws) bools = undefined


--TUI
initRow :: [Char]
initRow = replicate 46 '_'

initGrid :: [[Char]]
initGrid = replicate 46 initRow

keyMove :: Char -> IO ()
keyMove a =
  case a of
    'j' -> cursorDown 1
    'k' -> cursorUp 1
    'h' -> cursorBackward 1
    'l' -> cursorForward 1
    _   -> return ()


--Take a list of Ints
twoDify :: [Int] -> [[Int]]
twoDify []     = []
twoDify (x:xs) = map (+ x) [0..45] : twoDify xs

--Take Locations, a 2D BIPList and return the ind
getIndices :: [(Int, Int)] -> [[(Int, String)]] -> [Int]
getIndices []             m = []
getIndices ((x,y) : xys ) m = (fst $ (m !! y) !! x) : getIndices xys m

--Convert list of bip39 indices to the actual words
indicesToWords :: [Int] -> [String]
indicesToWords []         = []
indicesToWords (idx:idxs) = bip39words !! idx : indicesToWords idxs

--FLOW

--pl <- ask for length of total seed phrase
--sl <- ask for length of shuffle words
--ws <- get shuffle words
--g  <- listShuffleBIP ws
--display grid g
--case length of (X,Y) < (pl - sl) repeat displayGrid





main = do
    clearScreen
    --replicateM_ 46 $ putStrLn initRow
    setCursorPosition 5 0
    setTitle "Seed Phrase Gen"
    c <- getChar
    keyMove c
