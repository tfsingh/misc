{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore #-}
module Main where
import System.IO
import Data.Ord (comparing)
import Data.List (sortBy)
import Data.Set (Set)
import qualified Data.Set as Set

-- Rotate elements in a list k places to the left
rotate :: [a] -> Int -> [a]
rotate ls k = drop k' ls ++ take k' ls where k' = k `mod` length ls

-- Quicksort
quicksort :: Ord(a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort left ++ [x] ++ quicksort right where
    left = [ele | ele <- xs, ele < x]
    right = [ele | ele <- xs, ele >= x]

-- Flatten a list of nested lists
data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (List []) = []
flatten (Elem x) = [x]
flatten (List (x:xs)) = flatten x ++ flatten (List xs)

-- Sort a list of lists according to the length of sublists
sortLength :: [[a]] -> [[a]]
sortLength [] = []
sortLength ls = sortBy (\x y -> compare (length x) (length y)) ls

-- Binary tree inorder traversal
data Tree a = Empty | Branch a (Tree a) (Tree a) 
              deriving (Show, Eq)

inorder :: Tree a -> [a]
inorder Empty = []
inorder (Branch node left right) = inorder left ++ [node] ++ inorder right

-- N queens
data Visited = Visited { columns :: Set Int, diagonals :: Set Int, antidiagonals :: Set Int }

nqueens :: Int -> Int
nqueens n = nqueens' 0 Visited { columns = Set.empty, 
                                 diagonals = Set.empty,
                                 antidiagonals = Set.empty } where
    nqueens' row visited
        | row == n = 1
        | otherwise = sum [ nqueens' (row + 1) (updateVisited visited row col) | col <- [0..n-1], 
                            col `Set.notMember` cols,
                            (row + col) `Set.notMember` diags,
                            (row - col) `Set.notMember` adiags ]
        where
            cols = columns visited
            diags = diagonals visited
            adiags = antidiagonals visited
            updateVisited visited row col = Visited { columns = Set.insert col (columns visited),
                                                      diagonals = Set.insert (row + col) (diagonals visited), 
                                                      antidiagonals = Set.insert (row - col) (antidiagonals visited) }

main = do
    print $ rotate "abcdefgh" 9 -- "bcdefgha"
    print $ quicksort "baceadfg" -- "aabcdefg"
    print $ flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]]) -- [1,2,3,4,5]
    print $ sortLength ["abc", "de", "f", "ghi", "jk", "lmnop"] -- ["f","de","jk","abc","ghi","lmnop"]
    print $ inorder (Branch 4 (Branch 2 (Branch 1 Empty Empty) (Branch 3 Empty Empty)) (Branch 5 Empty Empty)) -- [1,2,3,4,5]
    print $ nqueens 8 -- 92