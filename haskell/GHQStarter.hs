{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore #-}
module Main where
import System.IO
import Data.Ord (comparing)
import Data.List (sortBy)
import Data.Set (Set)
import qualified Data.Set as Set

-- Rotate a list k places left
rotate :: [a] -> Int -> [a]
rotate ls k = undefined

-- Quicksort
quicksort :: Ord(a) => [a] -> [a]
quicksort [] = undefined

-- Flatten nested list
data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (List []) = undefined

--Sort a list of lists by length of sublists
sortLength :: [[a]] -> [[a]]
sortLength [] = undefined

-- Binary tree inorder traversal
data Tree a = Empty | Branch a (Tree a) (Tree a) 
              deriving (Show, Eq)

inorder :: Tree a -> [a]
inorder Empty = undefined

-- N-queens
data Visited = Visited { columns :: Set Int, diagonals :: Set Int, antidiagonals :: Set Int }

nqueens :: Int -> Int
nqueens n = undefined

main = do
    print $ rotate "abcdefgh" 9 -- "bcdefgha"
    print $ quicksort "baceadfg" -- "aabcdefg"
    print $ flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]]) -- [1,2,3,4,5]
    print $ sortLength ["abc", "de", "f", "ghi", "jk", "lmnop"] -- ["f","de","jk","abc","ghi","lmnop"]
    print $ inorder (Branch 4 (Branch 2 (Branch 1 Empty Empty) (Branch 3 Empty Empty)) (Branch 5 Empty Empty)) -- [1,2,3,4,5]
    print $ nqueens 8 -- 92