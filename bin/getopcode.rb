#!/usr/bin/env ruby
# Assemble instructions and extract the bytecode using the GNU as and objdump
# programs.  Hopefully works for multiple architectures.

require 'tempfile'
require 'optparse'

# Options
$as       = 'as'
$as_flags = ''
$objdump  = 'objdump'
$machine  = 'x86'
$xmos     = false

opts = OptionParser.new do |opts|
  opts.banner = "Usage: getopcode.rb [options]"
  opts.separator ""
  opts.separator "Specific options:"

  opts.on("-a", "--asm PROG", "Assembler to use") { |prog| $as = prog    }
  opts.on("-d", "--dump PROG", "Version of objdump to use") { |prog| $objdump = prog    }
  opts.on("-f", "--flags FLAGS", "Flags to pass to the assembler") { |flag| $as_flags = flag    }
  opts.on("-m", "--machine MACHINE", "Machine we are assembling on") { |mach| $machine = mach }
  opts.on("-x", "--xmos", "Use the XMOS alternate syntax for objdump") { $xmos = true }
  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end

opts.parse!(ARGV)

# Assemble an assembly instruction and get the bytecode generated
def assemble(op)
  dump = ""
  Tempfile.open(['getopcode','.o']) do |f|
    `echo '#{op}' | #{$as} #{$flags} -o #{f.path}`
    dump = `#{$objdump} -d #{f.path}`
  end

  unless $xmos 
    return extract_opcode(dump)
  else
    return xmos_extract_opcode(dump)
  end
end

# Extract the opcode out of the dump from objdump
def extract_opcode(dump)
  dump.each_line do |line|
    # If the line is a line of disassembled code...
    m = /\A\s+[0-9a-f]+:/i.match line

    # Extract the opcode field and remove any internal spaces
    return line.split(/\t/)[1].split.join unless m.nil?
  end
end

# A Special case for the XMOS development kit
def xmos_extract_opcode(dump)
  dump.each_line do |line|
    # If the line is a line of dissassembled code
    m = /\A\s+0x[0-9a-f]+:/i.match line

    # Extract the opcode field and remove any internal spaces
    return line.split(/:/)[1].split.join unless m.nil?
  end
end

# Split input into prefix ops, and suffix ops
def parse_input(line)
  prefix, suffix = line.split '|'
  prefixes = unless prefix.nil? then prefix.split(';') else [] end
  suffixes = unless suffix.nil? then suffix.split(';') else [] end
  return prefixes, suffixes
end


# Assemble the input
ARGF.each_line do |line|
  line.chomp!
  prefixes, suffixes = parse_input line
  compiled_prefixes = prefixes.map { |it| assemble it } 
  compiled_suffixes = suffixes.map { |it| assemble it }

  # Only print the command if it assembled successfully
  unless (compiled_prefixes.any? {|inst| inst == ''} or
          compiled_suffixes.any? {|inst| inst == ''} )
    print "#{$machine}|#{prefixes.join '; '}|#{suffixes.join ';'}|#{compiled_prefixes.join}|#{compiled_suffixes.join}\n"
  end


end
