#! /usr/bin/env ruby
# Conditional jumps all over the place
(0x70 .. 0x80).step(2).each do |op|
  puts "#{op.to_s 16}..#{(op+1).to_s 16}.."
  puts "#{(op+1).to_s 16}..#{op.to_s 16}.."
end

# Bigger conditional jumps!
(0x80 .. 0x90).step(2).each do |op|
  puts "0f#{op.to_s 16}.........#{(op+1).to_s 16}........."
  puts "0f#{(op+1).to_s 16}.........#{op.to_s 16}........."
end

# Absolute jumps
puts 'eb..'
puts 'e9.........'

