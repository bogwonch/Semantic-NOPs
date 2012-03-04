def endian_switch(x)
  x0 = x[6]
  x1 = x[7]
  x2 = x[4]
  x3 = x[5]
  x4 = x[2]
  x5 = x[3]
  x6 = x[0]
  x7 = x[1]

  return [x0,x1,x2,x3,x4,x5,x6,x7].join
end

# Unconditional jump
(0x8..0xb).each do |n|
  puts endian_switch("0#{n.to_s 16}......")
end


def jumpcode(op,r0,r1,c)
  str = sprintf "%06b%05b%05b" %  [op,r0,r1]
  str = sprintf "%04x" % str.to_i(2)
  return endian_switch([str,'...', c.to_s(16)].join)
end

# Two register conditional jumps
def beq(r0,r1,c)  jumpcode 0b000100,r0,r1,c end
def beql(r0,r1,c) jumpcode 0b010100,r0,r1,c end
def bne(r0,r1,c)  jumpcode 0b000101,r0,r1,c end
def bnel(r0,r1,c) jumpcode 0b010101,r0,r1,c end

# One register conditional jumps
def bgez(r0,c)  jumpcode 0b000001,r0,0b00001,c end
def bgezl(r0,c) jumpcode 0b000001,r0,0b00011,c end
def bgtz(r0,c)  jumpcode 0b000111,r0,0b00000,c end
def bgtzl(r0,c) jumpcode 0b010111,r0,0b00000,c end
def blez(r0,c)  jumpcode 0b000110,r0,0b00000,c end
def blezl(r0,c) jumpcode 0b010110,r0,0b00000,c end
def bltz(r0,c)  jumpcode 0b000001,r0,0b00000,c end
def bltzl(r0,c) jumpcode 0b000001,r0,0b00010,c end

# Meta programming for the win
def enum1r(op1,op2,r,c)
  puts [eval("b#{op1}  r, c"), eval("b#{op2}  r, c")].join
  puts [eval("b#{op1}  r, c"), eval("b#{op2}l r, c")].join
  puts [eval("b#{op1}l r, c"), eval("b#{op2}l r, c")].join
  puts [eval("b#{op1}l r, c"), eval("b#{op2}  r, c")].join
  puts [eval("b#{op2}  r, c"), eval("b#{op1}  r, c")].join
  puts [eval("b#{op2}  r, c"), eval("b#{op1}l r, c")].join
  puts [eval("b#{op2}l r, c"), eval("b#{op1}l r, c")].join
  puts [eval("b#{op2}l r, c"), eval("b#{op1}  r, c")].join
end

def enum2r(op1,op2,r0,r1,c)
  puts [eval("b#{op1}  r0,r1, c"), eval("b#{op2}  r0,r1, c")].join
  puts [eval("b#{op1}  r0,r1, c"), eval("b#{op2}l r0,r1, c")].join
  puts [eval("b#{op1}l r0,r1, c"), eval("b#{op2}l r0,r1, c")].join
  puts [eval("b#{op1}l r0,r1, c"), eval("b#{op2}  r0,r1, c")].join
  puts [eval("b#{op2}  r0,r1, c"), eval("b#{op1}  r0,r1, c")].join
  puts [eval("b#{op2}  r0,r1, c"), eval("b#{op1}l r0,r1, c")].join
  puts [eval("b#{op2}l r0,r1, c"), eval("b#{op1}l r0,r1, c")].join
  puts [eval("b#{op2}l r0,r1, c"), eval("b#{op1}  r0,r1, c")].join
end


(0..15).step(4).each do |c|
  (0..31).each do |r0|
    enum1r 'gez', 'ltz', r0, c
    enum1r 'gtz', 'lez', r0, c

    (0..31).each do |r1|
      enum2r 'eq','ne', r0,r1, c
    end
  end
end
