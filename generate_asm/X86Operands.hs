module X86Operands where

import Data.Int (Int8, Int16, Int32)

data Reg = { 
{- 64 |   32 |   16 |    8 |  8 | -}
  RAX | EAX  | AX   | AH   | AL | -- General Purpose
  RBX | EBX  | BX   | BH   | BL | -- General Purpose
  RCX | ECX  | CX   | CH   | CL | -- General Purpose
  RDX | EDX  | DX   | DH   | DL | -- General Purpose
  R8  | R8D  | R8W  | R8B  |      -- 64-bit mode only General Purpose
  R9  | R9D  | R9W  | R9B  |      -- 64-bit mode only General Purpose
  R10 | R10D | R10W | R10B |      -- 64-bit mode only General Purpose
  R11 | R11D | R11W | R11B |      -- 64-bit mode only General Purpose
  R12 | R12D | R12W | R12B |      -- 64-bit mode only General Purpose
  R13 | R13D | R13W | R13B |      -- 64-bit mode only General Purpose
  R14 | R14D | R14W | R14B |      -- 64-bit mode only General Purpose
  R15 | R15D | R15W | R15B |      -- 64-bit mode only General Purpose
               DS   |             -- Segment Registers
               SS   |             -- Segment Registers
               ES   |             -- Segment Registers
               FS   |             -- Segment Registers
               GS   |             -- Segment Registers
  RSP | ESP  | SP   | SPL  |      -- Pointer Registers
  RBP | EBP  | BP   | BPL  |      -- Pointer Registers
  RSI | ESI  | SI   | SIL  |      -- Index Registers
  RDI | EDI  | DI   | DIL  |      -- Index Registers
  RIP | EIP  | IP                 -- Instruction Pointer Register
} deriving (Eq)
  

data Imm8  = Imm8  Int8  deriving (Eq)
data Imm16 = Imm16 Int16 deriving (Eq)
data Imm32 = Imm32 Int32 deriving (Eq)


imm8  = fmap Imm8  [-0x80       .. 0x7f]
imm16 = fmap Imm16 [-0x8000     .. 0x7fff]
imm32 = fmap Imm32 [-0x80000000 .. 0x7fffffff]


instance Show Imm8 where
  show (Imm8 n) = "$"++show n

instance Show Imm16 where
  show (Imm16 n) = "$"++show n

instance Show Imm32 where
  show (Imm32 n) = "$"++show n



