module X86Operands where

import Data.Int (Int8, Int16, Int32)

data Reg =
  --64|____32|____16|_____8|___8|________TITLE________________________
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
 deriving (Eq)

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


r64 = [RAX,RBX,RCX,RDX,R8,R9,R10,R11,R12,R13,R14,R15,RSP,RBP,RSI,RDI,RIP]
r32 = [EAX,EBX,ECX,EDX,R8D,R9D,R10D,R11D,R12D,R13D,R14D,R15D,ESP,EBP,ESI,EDI,EIP]
r16 = [AX,BX,CX,DX,R8W,R9W,R10W,R11W,R12W,R13W,R14W,R15W,DS,SS,ES,FS,GS,SP,BP,SI,DI,IP]
r8  = [AH,BH,CH,DH,R8B,R9B,R10B,R11B,R12B,R13B,R14B,R15B,SPL,BPL,SIL,DIL,AL,BL,CL,DL]

general x = x `elem` [RAX,RBX,RCX,RDX,R8,R9,R10,R11,R12,R13,R14,R15
                     ,EAX,EBX,ECX,EDX,R8D,R9D,R10D,R11D,R12D,R13D,R14D,R15D
                     ,AX,BX,CX,DX,R8W,R9W,R10W,R11W,R12W,R13W,R14W,R15W
                     ,AH,BH,CH,DH,R8B,R9B,R10B,R11B,R12B,R13B,R14B,R15B
                     ]
segment x = x `elem` [DS,SS,ES,FS,GS]
pointer x = x `elem` [RSP,ESP,SP,SPL,RBP,EBP,BP,BPL,RIP,EIP,IP]
indexes x = x `elem` [RSI,ESI,SI,SIL,RDI,EDI,DI,DIL]
only64b x = x `elem` [R8,R8D,R8W,R8B,R9,R9D,R9W,R9B,R10,R10D,R10W,R10B,R11,R11D,R11W,R11B,R12,R12D,R12W,R12B,R13,R13D,R13W,R13B,R14,R14D,R14W,R14B,R15,R15D,R15W,R15B,SIL,DIL]

instance Show Reg where
  show RAX  = "%rax"
  show EAX  = "%eax"
  show AX   = "%ax"
  show AH   = "%ah"
  show AL   = "%al"
  show RBX  = "%rbx"
  show EBX  = "%ebx"
  show BX   = "%bx"
  show BH   = "%bh"
  show BL   = "%bl"
  show RCX  = "%rcx"
  show ECX  = "%ecx"
  show CX   = "%cx"
  show CH   = "%ch"
  show CL   = "%cl"
  show RDX  = "%rdx"
  show EDX  = "%edx"
  show DX   = "%dx"
  show DH   = "%dh"
  show DL   = "%dl"
  show R8   = "%r8"
  show R8D  = "%r8d"
  show R8W  = "%r8w"
  show R8B  = "%r8b"
  show R9   = "%r9"
  show R9D  = "%r9d"
  show R9W  = "%r9w"
  show R9B  = "%r9b"
  show R10  = "%r10"
  show R10D = "%r10d"
  show R10W = "%r10w"
  show R10B = "%r10b"
  show R11  = "%r11"
  show R11D = "%r11d"
  show R11W = "%r11w"
  show R11B = "%r11b"
  show R12  = "%r12"
  show R12D = "%r12d"
  show R12W = "%r12w"
  show R12B = "%r12b"
  show R13  = "%r13"
  show R13D = "%r13d"
  show R13W = "%r13w"
  show R13B = "%r13b"
  show R14  = "%r14"
  show R14D = "%r14d"
  show R14W = "%r14w"
  show R14B = "%r14b"
  show R15  = "%r15"
  show R15D = "%r15d"
  show R15W = "%r15w"
  show R15B = "%r15b"
  show DS   = "%ds"
  show SS   = "%ss"
  show ES   = "%es"
  show FS   = "%fs"
  show GS   = "%gs"
  show RSP  = "%rsp"
  show ESP  = "%esp"
  show SP   = "%sp"
  show SPL  = "%spl"
  show RBP  = "%rbp"
  show EBP  = "%ebp"
  show BP   = "%bp"
  show BPL  = "%bpl"
  show RSI  = "%rsi"
  show ESI  = "%esi"
  show SI   = "%si"
  show SIL  = "%sil"
  show RDI  = "%rdi"
  show EDI  = "%edi"
  show DI   = "%di"
  show DIL  = "%dil"
  show RIP  = "%rip"
  show EIP  = "%eip"
  show IP   = "%ip"

