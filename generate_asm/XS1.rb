#!/usr/bin/env ruby
# Semantic NOPS for XMOS's XS1
$output = 'XS1-semantic-nops'

$registers = (0..11).map {|n| "r#{n}"}
$us  = (0..11)
$u16 = (0..2**16-1)
$u20 = (0..2**20-1)

# A generic command for creating opcodes
def opcode(op,args) "#{op} #{args.join ','}" end

# Instructions we cas use for creating semantic nops
def ADD(d,x,y) opcode "add", [d,x,y] end
def BITREV(d,s) opcode "bitrev", [d,s] end
def BYTEREV(d,s) opcode "byterev", [d,s] end
def NEG(d,s) opcode "neg", [d,s] end
def NOT(d,s) opcode "not", [d,s] end
def SUB(d,x,y) opcode "sub", [d,x,y] end
def XOR(d,x,y) opcode "xor", [d,x,y] end

File.open($output, 'w') do |f|
  $registers.each do |r|
    # One register identity operations
    f.puts ADD r,r,0
    f.puts SUB r,r,0

    f.puts "#{BITREV r,r};#{BITREV r,r}"
    f.puts "#{BITREV r,r}|#{BITREV r,r}"

    f.puts "#{BYTEREV r,r};#{BYTEREV r,r}"
    f.puts "#{BYTEREV r,r}|#{BYTEREV r,r}"

    f.puts "#{NEG r,r};#{NEG r,r}"
    f.puts "#{NEG r,r}|#{NEG r,r}"

    f.puts "#{NOT r,r};#{NOT r,r}"
    f.puts "#{NOT r,r}|#{NOT r,r}"

    # Two register identity operations
    $registers.each do |s|
      f.puts "#{ADD r,r,s};#{SUB r,r,s}"
      f.puts "#{ADD r,r,s}|#{SUB r,r,s}"

      f.puts "#{SUB r,r,s};#{ADD r,r,s}"
      f.puts "#{SUB r,r,s}|#{ADD r,r,s}"

      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s}|#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s}|#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}|#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s};#{XOR s,r,s}|#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
      f.puts "#{XOR r,r,s}|#{XOR s,r,s};#{XOR r,r,s};#{XOR r,r,s};#{XOR s,r,s};#{XOR r,r,s}"
    end

    # One register, one immediate 
    $us.each do |i|
      f.puts "#{ADD r,r,i};#{SUB r,r,i}"
      f.puts "#{ADD r,r,i}|#{SUB r,r,i}"

      f.puts "#{SUB r,r,i};#{ADD r,r,i}"
      f.puts "#{SUB r,r,i}|#{ADD r,r,i}"
    end
  end
end


