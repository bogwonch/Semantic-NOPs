# Conditional jumps
(0x0..0xd).step(2).each do |c|
  puts "......#{c.to_s 16}a......#{(c+1).to_s 16}a"
  puts "......#{(c+1).to_s 16}a......#{c.to_s 16}a"
end

# Unconditional jump
puts '......ea'

# Move a value into the PC
puts '..f.a0e3'

# Conditionally move a value into the PC
(0x0..0xd).step(2).each do |c|
  puts "..f.a0#{c.to_s 16}3..f.a0#{(c+1).to_s 16}3"
  puts "..f.a0#{(c+1).to_s 16}3..f.a0#{c.to_s 16}3"
end

# Add something to the PC
puts '..f.8fe2'

# Conditionally add something to the PC
(0x0..0xd).step(2).each do |c|
  puts "..f.8f#{c.to_s 16}2..f.8f#{(c+1).to_s 16}2"
  puts "..f.8f#{(c+1).to_s 16}2..f.8f#{c.to_s 16}2"
end

# Subtract something to the PC
puts '..f.4fe2'

# Conditionally subtract something to the PC
(0x0..0xd).step(2).each do |c|
  puts "..f.4f#{c.to_s 16}2..f.4f#{(c+1).to_s 16}2"
  puts "..f.4f#{(c+1).to_s 16}2..f.4f#{c.to_s 16}2"
end

