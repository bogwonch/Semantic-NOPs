module X86Operands where

import Data.Int (Int8, Int16, Int32)

data R16 = AX  | BX  | CX   | DX   | SI   | DI   | SP   | BP
         | G8X | G9X | G10X | G11X | G12X | G13X | G14X | G15X
  deriving (Eq)

data R32 = EAX | EBX | ECX  | EDX  | ESI  | EDI  | ESP  | EBP  
         | E8X | E9X | E10X | E11X | E12X | E13X | E14X | E15X
  deriving (Eq)

data R64 = RAX | RBX | RCX  | RDX  | RSI  | RDI  | RSP  | RBP  
         | R8X | R9X | R10X | R11X | R12X | R13X | R14X | R15X
  deriving (Eq)

data Imm8  = Imm8  Int8  deriving (Eq)
data Imm16 = Imm16 Int16 deriving (Eq)
data Imm32 = Imm32 Int32 deriving (Eq)

r16 = [AX,BX,CX,DX,SI,DI,SP,BP,G8X,G9X,G10X,G11X,G12X,G13X,G14X,G15X]
r32 = [EAX,EBX,ECX,EDX,ESI,EDI,ESP,EBP,E8X,E9X,E10X,E11X,E12X,E13X,E14X,E15X]
r64 = [RAX,RBX,RCX,RDX,RSI,RDI,RSP,RBP,R8X,R9X,R10X,R11X,R12X,R13X,R14X,R15X]

imm8  = fmap Imm8  [-0x80       .. 0x7f]
imm16 = fmap Imm16 [-0x8000     .. 0x7fff]
imm32 = fmap Imm32 [-0x80000000 .. 0x7fffffff]

instance Show R16 where
  show AX   = "%ax"
  show BX   = "%bx"
  show CX   = "%cx"
  show DX   = "%dx"
  show SI   = "%si"
  show DI   = "%di"
  show SP   = "%sp"
  show BP   = "%bp"
  show G8X  = "%8x"
  show G9X  = "%9x"
  show G10X = "%10x"
  show G11X = "%11x"
  show G12X = "%12x"
  show G13X = "%13x"
  show G14X = "%14x"
  show G15X = "%15x"

instance Show R32 where
  show EAX  = "%eax"
  show EBX  = "%ebx"
  show ECX  = "%ecx"
  show EDX  = "%edx"
  show ESI  = "%esi"
  show EDI  = "%edi"
  show ESP  = "%esp"
  show EBP  = "%ebp"
  show E8X  = "%e8x"
  show E9X  = "%e9x"
  show E10X = "%e10x"
  show E11X = "%e11x"
  show E12X = "%e12x"
  show E13X = "%e13x"
  show E14X = "%e14x"
  show E15X = "%e15x"

instance Show R64 where
  show RAX  = "%rax"
  show RBX  = "%rbx"
  show RCX  = "%rcx"
  show RDX  = "%rdx"
  show RSI  = "%rsi"
  show RDI  = "%rdi"
  show RSP  = "%rsp"
  show RBP  = "%rbp"
  show R8X  = "%r8x"
  show R9X  = "%r9x"
  show R10X = "%r10x"
  show R11X = "%r11x"
  show R12X = "%r12x"
  show R13X = "%r13x"
  show R14X = "%r14x"
  show R15X = "%r15x"

instance Show Imm8 where
  show (Imm8 n) = "$"++show n

instance Show Imm16 where
  show (Imm16 n) = "$"++show n

instance Show Imm32 where
  show (Imm32 n) = "$"++show n



