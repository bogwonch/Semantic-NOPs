module JVM
  def aconst_null() "01" end
  def bipush(n) sprintf "10%02x" % [n % 0x100] end
  def d2i() "8e" end
  def d2l() "8f" end
  def dadd() "63" end
  def dcmpg() "98" end
  def dcmpl() "97" end
  def dconst_0() "0e" end
  def dconst_1() "0f" end
  def ddiv() "6f" end
  def dmul() "6b" end
  def dneg() "77" end
  def drem() "73" end
  def dsub() "67" end
  def dup() "59" end
  def dup_x1() "5a" end
  def dup2() "5c" end
  def f2d() "8d" end
  def f2i() "8b" end
  def f2l() "8c" end
  def fadd() "62" end
  def fcmpg() "96" end
  def fcmpl() "95" end
  def fconst_0() "0b" end
  def fconst_1() "0c" end
  def fconst_2() "0d" end
  def fdiv() "6e" end
  def fmul() "6a" end
  def fneg() "76" end
  def frem() "72" end
  def fsub() "66" end
  def goto(n,m) sprintf "a7%02x%02x" % [n % 0x100, m % 0x100] end
  def goto_w(n,m,o,p) sprintf "c8%02x%02x%02x%02x" % [n % 0x100, m % 0x100, o % 0x100, p % 0x100] end
  def i2b() "91" end
  def i2d() "87" end
  def i2f() "86" end
  def i2l() "85" end
  def i2s() "93" end
  def iadd() "60" end
  def iconst_m1() "02" end
  def iconst_0() "03" end
  def iconst_1() "04" end
  def iconst_2() "05" end
  def iconst_3() "06" end
  def iconst_4() "07" end
  def iconst_5() "08" end
  def idiv() "6c" end
  def if_icmpeq(m,n) sprintf "9f%02x%02x" % [m % 0x100, n % 0x100] end
  def if_icmpne(m,n) sprintf "a0%02x%02x" % [m % 0x100, n % 0x100] end
  def if_icmplt(m,n) sprintf "a1%02x%02x" % [m % 0x100, n % 0x100] end
  def if_icmpge(m,n) sprintf "a2%02x%02x" % [m % 0x100, n % 0x100] end
  def if_icmpgt(m,n) sprintf "a3%02x%02x" % [m % 0x100, n % 0x100] end
  def if_icmple(m,n) sprintf "a4%02x%02x" % [m % 0x100, n % 0x100] end
  def ifeq(m,n) sprintf "99%02x%02x" % [m % 0x100, n % 0x100] end
  def ifne(m,n) sprintf "9a%02x%02x" % [m % 0x100, n % 0x100] end
  def iflt(m,n) sprintf "9b%02x%02x" % [m % 0x100, n % 0x100] end
  def ifge(m,n) sprintf "9c%02x%02x" % [m % 0x100, n % 0x100] end
  def ifgt(m,n) sprintf "9d%02x%02x" % [m % 0x100, n % 0x100] end
  def ifle(m,n) sprintf "9e%02x%02x" % [m % 0x100, n % 0x100] end
  def ifnonnull(m,n) sprintf "c7%02x%02x" % [m % 0x100, n % 0x100] end
  def ifnull(m,n) sprintf "c6%02x%02x" % [m % 0x100, n % 0x100] end
  def imul() "68" end
  def ineg() "74" end
  def ior() "80" end
  def irem() "70" end
  def ishl() "78" end
  def ishr() "7a" end
  def isub() "64" end
  def iushr() "7c" end
  def ixor() "82" end
  def l2d() "8a" end
  def l2f() "89" end
  def l2i() "88" end
  def ladd() "61" end
  def land() "7f" end
  def lcmp() "94" end
  def lconst_0() "09" end
  def lconst_1() "0a" end
  def ldiv() "6d" end
  def lmul() "69" end
  def lneg() "75" end
  def lor() "81" end
  def lrem() "71" end
  def lshl() "79" end
  def lshr() "7b" end
  def lsub() "65" end
  def lushr() "7d" end
  def lxor() "83" end
  def nop() "00" end
  def pop() "57" end
  def pop2() "58" end
  def sipush(m,n) sprintf "11%02x%02x" % [m % 0x100, n % 0x100] end
  def swap() "5f" end
end

