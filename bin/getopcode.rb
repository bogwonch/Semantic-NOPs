#!/usr/bin/env ruby
# Assemble instructions and extract the bytecode using GNU as and objdump

require 'tempfile'
require 'optparse'

# Options
$as = 'as'
$as_flags = ''
$objdump = 'objdump'

opts = OptionParser.new do |opts|
  opts.banner = "Usage: getopcode.rb [options]"
  opts.separator ""
  opts.separator "Specific options:"

  opts.on("-a", "--asm PROG", "Assembler to use")                  { |prog| $as       = prog }
  opts.on("-d", "--dump PROG", "Version of objdump to use")        { |prog| $objdump  = prog }
  opts.on("-f", "--flags FLAGS", "Flags to pass to the assembler") { |flag| $as_flags = flag }
  opts.on("-h", "--help", "Show this message") {
    puts opts
    exit
  }
end

opts.parse!(ARGV)

# Assemble an assembly instruction and get the bytecode generated
def assemble(op)
  dump = ""
  Tempfile.open('getopcode') do |f|
    `echo '#{op}' | #{$as} #{$flags} -o #{f.path}`
    dump = `#{$objdump} -d #{f.path}`
  end

  dump.each_line do |line|
    # If the line is a line of disassembled code...
    m = /\A\s+[0-9a-f]+:/i.match line

    # Extract the opcode field and remove any internal spaces
    yield line.split(/\t/)[1].split.join unless m.nil?
  end
end


ARGF.each_line do |line|
  line.chomp!
  assemble(line) { |op| print "#{op}|#{line}\n" }
end
