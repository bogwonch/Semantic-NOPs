#!/usr/bin/env ruby
# Jump instructions for ARM
$output = "MIPS-jumps"

$registers = 0.upto(31).map { |n| "$#{n}" }
$addresses = (-0xfffc..0xffff).step 4

# A generic command for creating opcodes
def opcode(op,args) "#{op} #{args.join ','}" end

# Instructions we cas use for creating semantic nops
def BEQ(r1,r2,address) opcode "BEQ", [r1,r2,address] end
def BNE(r1,r2,address) opcode "BNE", [r1,r2,address] end
def J(address) opcode "J", [address] end

File.open($output, 'w') do |f|
  $addresses.each do |addr|
    f.puts "#{J addr}"

    $registers.each do |r1|
      $registers.each do |r2|
        f.puts "#{BEQ r1,r2,addr};#{BNE r1,r2,addr}"
        f.puts "#{BEQ r1,r2,addr}|#{BNE r1,r2,addr}"

        f.puts "#{BNE r1,r2,addr};#{BEQ r1,r2,addr}"
        f.puts "#{BNE r1,r2,addr}|#{BEQ r1,r2,addr}"
      end
    end
  end
end

