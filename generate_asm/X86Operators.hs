module X86Operators where

import X86Operands
import Text.Printf

nops1I = movsxd ++ mov ++ xchg ++ nop ++ cmov
nops2I = pushPop ++ xchgXchg ++ pushfPopf ++ notNot

-- Move with sign extension
movsxd = ["movsxd "++show dest++","++show dest | dest <- r32]

-- Move
mov = ["mov "++show dest++","++show dest | dest <- r16] ++
      ["mov "++show dest++","++show dest | dest <- r32] ++
      ["mov "++show dest++","++show dest | dest <- r64]

-- Exchange register with register
xchg = ["xchg "++show r | r <- r16] ++
       ["xchg "++show r | r <- r32] ++
       ["xchg "++show r | r <- r64] 

-- No operation
nop = ["nop"] ++
      ["nop "++show r | r <- r16 ] ++
      ["nop "++show r | r <- r32 ] 

-- Conditional Moves
cmov = 
  ["cmova "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmova " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmova " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovc "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovc " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovc " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovg "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovg " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovg " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovl "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovl " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovl " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovo "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovo " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovo " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovp "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovp " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovp " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovs "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovs " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovs " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovz "  ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovz " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovz " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovna " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmova " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmova " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovnc " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovc " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovc " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovng " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovg " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovg " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovnl " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovl " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovl " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovno " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovo " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovo " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovnp " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovp " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovp " ++ show r ++ "," ++ show r | r <- r64 ] ++
  ["cmovns " ++ show r ++ "," ++ show r | r <- r16 ] ++ ["cmovs " ++ show r ++ "," ++ show r | r <- r32 ] ++ ["cmovs " ++ show r ++ "," ++ show r | r <- r64 ]

-- Move with sign extension
movsx

-- Push followed by Pop
pushPop = [ ("push "++show r, "pop "++show r) | r <- r64 ] ++
          [ ("push "++show r, "pop "++show r) | r <- r16 ]

xchgXchg = [ ("xchg "++show r1++","++show r2, "xchg "++show r1++","++show r2) | r1 <- r16, r2 <- r16, r1 /= r2 ] ++
           [ ("xchg "++show r1++","++show r2, "xchg "++show r1++","++show r2) | r1 <- r32, r2 <- r32, r1 /= r2 ] ++
           [ ("xchg "++show r1++","++show r2, "xchg "++show r1++","++show r2) | r1 <- r64, r2 <- r64, r1 /= r2 ]

pushfPopf = [("pushf","popf")]

notNot = [ ("not "++show r, "not "++show r) | r <- r16 ]++
         [ ("not "++show r, "not "++show r) | r <- r32 ]++
         [ ("not "++show r, "not "++show r) | r <- r64 ]
          
