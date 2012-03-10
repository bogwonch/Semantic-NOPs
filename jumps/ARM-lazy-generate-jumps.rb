#! /usr/bin/env ruby

def endian_switch(x)
  b1 = "#{x[0]}#{x[1]}"
  b2 = "#{x[2]}#{x[3]}"
  b3 = "#{x[4]}#{x[5]}"
  b4 = "#{x[6]}#{x[7]}"

  return b4 b3 b2 b1
end


# Conditional jumps
(0x0..0xd).step(2).each do |c|
  puts "#{c.to_s 16}a......#{(c+1).to_s 16}a......"
  puts "#{(c+1).to_s 16}a......#{c.to_s 16}a......"
end

# Unconditional jump
puts 'ea......'

# Move a value into the PC
puts 'e3a0f...'

# Conditionally move a value into the PC
(0x0..0xd).step(2).each do |c|
  puts "#{c.to_s 16}3a0f...#{(c+1).to_s 16}3a0f..."
  puts "#{(c+1).to_s 16}3a0f...#{c.to_s 16}3a0f..."
end

# Add something to the PC
puts 'e28ff...'

# Conditionally add something to the PC
(0x0..0xd).step(2).each do |c|
  puts "#{c.to_s 16}28ff...#{(c+1).to_s 16}28ff..."
  puts "#{(c+1).to_s 16}28ff...#{c.to_s 16}28ff..."
end

# Subtract something to the PC
puts 'e24ff...'

# Conditionally subtract something to the PC
(0x0..0xd).step(2).each do |c|
  puts "#{c.to_s 16}24ff...#{(c+1).to_s 16}24ff..."
  puts "#{(c+1).to_s 16}24ff...#{c.to_s 16}24ff..."
end

