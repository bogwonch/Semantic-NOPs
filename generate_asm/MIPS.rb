#!/usr/bin/env ruby
# Semantic NOPS for MIPS
$output = 'MIPS-semantic-nops'

$registers = (0..31).map {|n| "$#{n}"}
$imm16 = (0..2**16-1)
def opcode(op,args) "#{op} #{args.join ','}" end

# Instructions we cas use for creating semantic nops
def ADDI(d,s,t) opcode "ADDI", [d,s,t] end
def ADDIU(d,s,t) opcode "ADDIU", [d,s,t] end
def ADDU(d,s,t) opcode "ADDU", [d,s,t] end
def AND(d,s,t) opcode "AND", [d,s,t] end
def ANDI(d,s,c) opcode "ANDI", [d,s,c] end
def LUI(d,c) opcode "LUI", [d,c] end
def NOR(d,s,t) opcode "NOR", [d,s,t] end
def ORI(d,s,c) opcode "ORI", [d,s,c] end
def SLT(d,s,t) opcode "SLT", [d,s,t] end
def SLTI(d,s,c) opcode "SLTI", [d,s,c] end
def SUBI(d,s,t) opcode "SUBI", [d,s,t] end
def SUBIU(d,s,t) opcode "SUBIU", [d,s,t] end
def SUBU(d,s,t) opcode "SUBU", [d,s,t] end
def XOR(d,s,c) opcode "XOR", [d,s,c] end

File.open($output, 'w') do |f|
  f.puts "NOP"

  $registers.each do |r|
    # One register identitiy
    f.puts ADDI r, r, 0
    f.puts SUBI r, r, 0
    f.puts ANDI r, r, 2*16-1
    f.puts ORI r, r, 0

    $imm16.each do |i|
      # One register one immediate exploiting $0
      f.puts ADDIU '$0', r, i
      f.puts SUBIU '$0', r, i
      f.puts ANDI '$0', r, i
      f.puts ORI '$0', r, i
      f.puts SLTI '$0', r, i

      # Two operation identities with an immediate
      f.puts "#{ADDIU r,r,i};#{SUBIU r,r,i}"
      f.puts "#{ADDIU r,r,i}|#{SUBIU r,r,i}"

      f.puts "#{SUBIU r,r,i};#{ADDIU r,r,i}"
      f.puts "#{SUBIU r,r,i}|#{ADDIU r,r,i}"
    end

    $registers.each do |s|
      # Exploiting $0 being held at 0 with two registers
      f.puts ADDU '$0', r, s
      f.puts SUBU '$0', r, s
      f.puts AND '$0', r, s
      f.puts XOR '$0', r, s
      f.puts NOR '$0', r, s
      f.puts SLT '$0', r, s

      # Two operation identities
      f.puts "#{ADDU r,r,s};#{SUBU r,r,s}"
      f.puts "#{ADDU r,r,s}|#{SUBU r,r,s}"

      f.puts "#{SUBU r,r,s};#{ADDU r,r,s}"
      f.puts "#{SUBU r,r,s}|#{ADDU r,r,s}"

      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s}|#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s}|#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}|#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s}|#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s}|#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
    end
  end

  $imm16.each do |i|
    # Exploit immediate with $0
    f.puts LUI '$0',i
  end

end


