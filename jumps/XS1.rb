#!/usr/bin/env ruby
# Jump instructions for ARM
$output = "XS1-jumps"

$registers = 0.upto(11).map { |n| "r#{n}" }
$addresses = (-0xffff..0xffff).step 4

# A generic command for creating opcodes
def opcode(op,args) "#{op} #{args.join ','}" end

def BU(addr) opcode 'BU', [addr] end
def BT(r,addr) opcode 'BT', [r,addr] end
def BF(r,addr) opcode 'BF', [r,addr] end


File.open($output, 'w') do |f|
  $addresses.each do |addr|
    f.puts BU addr

    $registers.each do |r|
      f.puts "#{BT r, addr};#{BF r, addr}"
      f.puts "#{BT r, addr}|#{BF r, addr}"
      f.puts "#{BF r, addr};#{BT r, addr}"
      f.puts "#{BF r, addr}|#{BT r, addr}"
    end
  end
end

