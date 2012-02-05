#!/usr/bin/env ruby
# Semantic NOPS for ARM
$output = 'ARM-semantic-nops'

$registers = (0..14).map {|n| "r#{n}"}
$condition = ['EQ','NE','CS','CC','MI',
              'PL','VS','VC','HI','LS',
              'GE','LT','GT','LE','AL']
$imm8  = (0..2**8-1) .map {|n| "##{n}"}
$imm16 = (0..2**16-1).map {|n| "##{n}"}

# A generic command for creating opcodes
def opcode(op,cond,args) "#{op}#{cond} #{args.join ','}" end

# Instructions we cas use for creating semantic nops
def ADD(cond,d,a,b) opcode("ADD",cond, [d,a,b]) end
def SUB(cond,d,a,b) opcode("SUB",cond, [d,a,b]) end
def RSB(cond,d,a,b) opcode("RSB",cond, [d,a,b]) end
def MUL(cond,d,a,b) opcode("MUL",cond, [d,a,b]) end
def MOV(cond,d,a)   opcode("MOV",cond, [d,a]) end
def AND(cond,d,a,b) opcode("AND",cond, [d,a,b]) end
def EOR(cond,d,a,b) opcode("EOR",cond, [d,a,b]) end
def ORR(cond,d,a,b) opcode("ORR",cond, [d,a,b]) end
def RBIT(cond,d,a)  opcode("RBIT",cond, [d,a]) end
def REV(cond,d,a)   opcode("REV",cond, [d,a]) end
def REV16(cond,d,a) opcode("REV16",cond, [d,a]) end


File.open($output, 'w') do |f|
  # Simple NOPs (some of these may be detrimental to performance!)
  f.puts 'NOP'
  f.puts 'DMB'
  f.puts 'DSB'
  f.puts 'ISB'

  $condition.each do |cond|
    $registers.each do |r|
      # Simple one instruction semantic-nops
      f.puts ADD cond, r, r, '#0'
      f.puts SUB cond, r, r, '#0'
      f.puts MOV cond, r, r
      f.puts AND cond, r, r, '#0xFFFFFFFF'
      f.puts EOR cond, r, r, '#0'

      # Two instruction semantic-nops
      f.puts "#{REV cond,r,r};#{REV cond,r,r}"
      f.puts "#{REV cond,r,r}|#{REV cond,r,r}"

      f.puts "#{REV16 cond,r,r};#{REV16 cond,r,r}"
      f.puts "#{REV16 cond,r,r}|#{REV16 cond,r,r}"

      # Reversible two register operations
      $registers.each do |s|
        f.puts "#{ADD cond,r,r,s};#{SUB cond,r,r,s}"
        f.puts "#{ADD cond,r,r,s}|#{SUB cond,r,r,s}"

        f.puts "#{SUB cond,r,r,s};#{ADD cond,r,r,s}"
        f.puts "#{SUB cond,r,r,s}|#{ADD cond,r,r,s}"

        f.puts "#{EOR cond,r,r,s};#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s}|#{EOR cond,r,r,s}"

          # Swap two registers---twice
        f.puts "#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s};#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s};#{EOR cond,r,r,s};#{EOR cond,s,r,s}|#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s};#{EOR cond,r,r,s}|#{EOR cond,s,r,s};#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s}|#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s};#{EOR cond,s,r,s}|#{EOR cond,r,r,s};#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s}|#{EOR cond,s,r,s};#{EOR cond,r,r,s};#{EOR cond,r,r,s};#{EOR cond,s,r,s};#{EOR cond,r,r,s}"
      end

      # Operations with immediates
      $imm8.each do |s|
        f.puts "#{ADD cond,r,r,s};#{SUB cond,r,r,s}"
        f.puts "#{ADD cond,r,r,s}|#{SUB cond,r,r,s}"

        f.puts "#{SUB cond,r,r,s};#{ADD cond,r,r,s}"
        f.puts "#{SUB cond,r,r,s}|#{ADD cond,r,r,s}"

        f.puts "#{EOR cond,r,r,s};#{EOR cond,r,r,s}"
        f.puts "#{EOR cond,r,r,s}|#{EOR cond,r,r,s}"
      end
    end
  end
end


