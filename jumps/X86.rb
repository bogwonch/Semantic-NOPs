#!/usr/bin/env ruby
# Semantic NOPS for X86-64... assemble in intel syntax mode: -msyntax=intel
$output = 'X8664-jumps'

$addresses = (-0xfffffff .. 0xfffffff)

$cond = ["A", "C", "G", "L", "O", "P", "S", "Z",
         "NA", "NC", "NG", "NL", "NO", "NP", "NS"]

def opposite(c)
  case c
  when 'A'
    return 'NA'
  when 'C'
    return 'NC'
  when 'G'
    return 'NG'
  when 'L'
    return 'NL'
  when 'O'
    return 'NO'
  when 'P'
    return 'NP'
  when 'S'
    return 'NS'
  when 'Z'
    return 'NZ'

  when 'NA'
    return 'A'
  when 'NC'
    return 'C'
  when 'NG'
    return 'G'
  when 'NL'
    return 'L'
  when 'NO'
    return 'O'
  when 'NP'
    return 'P'
  when 'NS'
    return 'S'
  when 'NZ'
    return 'Z'
  end
end

# A generic command for creating opcodes
def opcode(op,args) "#{op} #{args.join ','}" end
def copcode(op,cond,args) opcode(op+cond, args) end

def JMP(addr) opcode "JMP", ["$+#{addr}"] end
def CJMP(cond,addr) copcode "JMP", cond, ["$+#{addr}"] end

File.open($output, 'w') do |f|
  $addresses.each do |addr|
    # Relative jumps
    f.puts JMP addr

    $cond.each do |c|
      f.puts "#{CJMP c, addr};#{CJMP opposite(c), addr}"
      f.puts "#{CJMP c, addr}|#{CJMP opposite(c), addr}"
    end
  end
end

