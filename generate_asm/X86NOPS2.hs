module Main where

import X86Operators (nops2I)

main = mapM_ (\(prefix,suffix) -> putStrLn $ prefix++" | "++suffix) nops2I


