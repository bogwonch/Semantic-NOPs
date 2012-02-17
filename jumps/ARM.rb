#!/usr/bin/env ruby
# Jump instructions for ARM
$output = "/dev/stdout"

$condition = ['EQ','NE','CS','CC','MI',
              'PL','VS','VC','HI','LS',
              'GE','LT','GT','LE','AL']
$imm32M = (-32*2**20 .. 32*2**20).step 4

# A generic command for creating opcodes
def opcode(op,cond,args) "#{op}#{cond} #{args.join ','}" end

# Instructions we cas use for creating semantic nops
def ADD(cond,d,a,b) opcode("ADD",cond, [d,a,b]) end
def SUB(cond,d,a,b) opcode("SUB",cond, [d,a,b]) end
def MOV(cond,d,a)   opcode("MOV",cond, [d,a]) end
def B(cond,a)       opcode("B",cond, [a]) end

# Find the opposite conditional
def opposite(n)
  case n
  when 'EQ' 
    return 'NE'
  when 'NE'
    return 'EQ'
  when 'CS'
    return 'CC'
  when 'CC'
    return 'CS'
  when 'MI'
    return 'PL'
  when 'PL'
    return 'MI'
  when 'HI'
    return 'LS'
  when 'LS'
    return 'HI'
  when 'GE'
    return 'LT'
  when 'LT'
    return 'GE'
  when 'GT'
    return 'LE'
  when 'LE'
    return 'GT'
  when 'AL'
    return 'AL'
  end    
end

File.open($output, 'w') do |f|
  $imm32M.each do |d|
    f.puts B 'AL', d
    f.puts MOV 'AL', 'PC', "##{d}"
    f.puts ADD 'AL', 'PC', 'PC', d
    f.puts SUB 'AL', 'PC', 'PC', d
    
    # For each condition except always
    $condition.each do |cond|
      unless (cond == 'AL')
        f.puts "#{B cond,d}|#{B opposite(cond),d}"
        f.puts "#{B cond,d};#{B opposite(cond),d}"
        f.puts "#{MOV cond,'PC',"##{d}"}|#{MOV opposite(cond),'PC',"##{d}"}"
        f.puts "#{MOV cond,'PC',"##{d}"};#{MOV opposite(cond),'PC',"##{d}"}"
        f.puts "#{ADD cond,'PC','PC',"##{d}"}|#{ADD opposite(cond),'PC','PC',"##{d}"}"
        f.puts "#{ADD cond,'PC','PC',"##{d}"};#{ADD opposite(cond),'PC','PC',"##{d}"}"
        f.puts "#{SUB cond,'PC','PC',"##{d}"}|#{SUB opposite(cond),'PC','PC',"##{d}"}"
        f.puts "#{SUB cond,'PC','PC',"##{d}"};#{SUB opposite(cond),'PC','PC',"##{d}"}"
      end
    end
  end
end

