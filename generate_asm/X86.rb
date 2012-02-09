#!/usr/bin/env ruby
# Semantic NOPS for X86-64
$output = 'X8664-semantic-nops'

$reg64 = ['%rax', '%rbx', '%rcx', '%rdx', 
          '%r8', '%r9', '%r10', '%r11', 
          '%r12', '%r13', '%r14', '%r15']
$reg32 = ['%eax', '%ebx', '%ecx', '%edx', 
          '%r8d', '%r9d', '%r10d', '%r11d', 
          '%r12d', '%r13d', '%r14d', '%r15d']
$reg16 = ['%ax', '%bx', '%cx', '%dx', 
          '%r8w', '%r9w', '%r10w', '%r11w', 
          '%r12w', '%r13w', '%r14w', '%r15w']
$reg8  = ['%ah', '%bh', '%ch', '%dh', 
          '%al', '%bl', '%cl', '%dl', 
          '%r8b', '%r9b', '%r10b', '%r11b', 
          '%r12b', '%r13b', '%r14b', '%r15b']

#$imm8  = (0..2**8-1) .map {|n| "$#{n}"}
#$imm16 = (0..2**16-1).map {|n| "$#{n}"}
#$imm32 = (0..2**32-1).map {|n| "$#{n}"}

$cond = ["a", "c", "g", "l", "o", "p", "s", "z",
         "na", "nc", "ng", "nl", "no", "np", "ns"]

# A generic command for creating opcodes
def opcode(op,args) "#{op} #{args.join ','}" end
def copcode(op,cond,args) opcode(op+cond, args) end

# Instructions we cas use for creating semantic nops
def MOVSXD(a,b)     opcode "MOVSXD", [a,b] end
def MOV(a,b)        opcode "MOV", [a,b] end
def XCHG(a,b)       opcode "XCHG", [a,b] end
def NOP(a)          opcode "NOP", [a] end
def CMOV(cond,a,b) copcode "CMOV", cond, [a,b] end
def PUSH(a)         opcode "PUSH", [a] end
def POP(a)          opcode "POP", [a] end
def NOT(a)          opcode "NOT", [a] end
def BSWAP(a,b)      opcode "BSWAP", [a,b] end
def LEA(a,b)        opcode "LEA", ["(#{a})", b] end

File.open($output, 'w') do |f|
  # Simple NOPs (some of these may be detrimental to performance!)
  f.puts 'NOP'
  f.puts 'PUSHF;POPF'
  f.puts 'PUSHF|POPF'

  $reg64.each do |r|
    f.puts MOV r,r
    f.puts XCHG r,r
    f.puts LEA r,r

    f.puts "#{PUSH r};#{POP r}"
    f.puts "#{PUSH r}|#{POP r}"

    f.puts "#{NOT r};#{NOT r}"
    f.puts "#{NOT r}|#{NOT r}"

    $cond.each do |cond|
      f.puts CMOV cond, r,r
    end

    $reg64.each do |s|
      f.puts "#{XCHG r,s};#{XCHG s,r}"
      f.puts "#{XCHG r,s}|#{XCHG s,r}"

      f.puts "#{BSWAP r,s};#{BSWAP s,r}"
      f.puts "#{BSWAP r,s}|#{BSWAP s,r}"
    end
  end

  $reg32.each do |r|
    f.puts MOV r,r
    f.puts MOVSXD r,r
    f.puts XCHG r,r
    f.puts NOP r
    f.puts LEA r,r

    f.puts "#{NOT r};#{NOT r}"
    f.puts "#{NOT r}|#{NOT r}"

    $cond.each do |cond|
      f.puts CMOV cond, r,r
    end

    $reg32.each do |s|
      f.puts "#{XCHG r,s};#{XCHG s,r}"
      f.puts "#{XCHG r,s}|#{XCHG s,r}"

      f.puts "#{BSWAP r,s};#{BSWAP s,r}"
      f.puts "#{BSWAP r,s}|#{BSWAP s,r}"
    end
  end

  $reg16.each do |r|
    f.puts MOV r,r
    f.puts XCHG r,r
    f.puts NOP r

    f.puts "#{PUSH r};#{POP r}"
    f.puts "#{PUSH r}|#{POP r}"

    f.puts "#{NOT r};#{NOT r}"
    f.puts "#{NOT r}|#{NOT r}"

    $cond.each do |cond|
      f.puts CMOV cond, r,r
    end

    $reg16.each do |s|
      f.puts "#{XCHG r,s};#{XCHG s,r}"
      f.puts "#{XCHG r,s}|#{XCHG s,r}"

      f.puts "#{BSWAP r,s};#{BSWAP s,r}"
      f.puts "#{BSWAP r,s}|#{BSWAP s,r}"
    end
  end

  $reg8.each do |r|
    f.puts MOV r,r
    f.puts XCHG r,r

    f.puts "#{NOT r};#{NOT r}"
    f.puts "#{NOT r}|#{NOT r}"

    $reg8.each do |s|
      f.puts "#{XCHG r,s};#{XCHG s,r}"
      f.puts "#{XCHG r,s}|#{XCHG s,r}"
    end
  end
end

