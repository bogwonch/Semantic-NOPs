#! /usr/bin/env ruby

require 'JVM'
$output = 'jvm-semantic-nops'


def dbline(f, prefix, suffix, c_prefix, c_suffix)
  f.puts "jvm|#{prefix.join ';'}|#{suffix.join ';'}|#{c_prefix.join}|#{c_suffix.join}"
end

def inst(f, instructions, bytecode)
end
  
# SEMANTIC NOPs!
File.open($output, 'w') do |f|

  dbline(f, [ 'bipush ..', 'pop'],                 [ ],                      [ '10..', '57'],       [ ])
  dbline(f, [ 'bipush ..']                         [ 'pop'],                 [ '10..'],             [ '57'])
  dbline(f, [ 'bipush ..', 'bipush ,,', 'pop2'],   [ ]                       [ '10..','10,,','58'], [ ])
  dbline(f, [ 'bipush ..', 'bipush ,,'],           [ 'pop2' ]                [ '10..','10,,'],      [ '58' ])
  dbline(f, [ 'bipush ..'],           [ 'bipush ,,', 'pop2' ]                [ '10..'],      [ '10,,', '58' ])

  
  inst [ 'aconst_null','pop'],                [ '01','57']
  inst [ 'aconst_null','aconst_null','pop2'], [ '01','01','58']
  inst [ 'bipush ..','pop'],                  [ '10..','57']
  inst [ 'bipush ..','bipush ,,','pop2'],     [ '10..','10,,','57']
  inst [ 'dconst_0','pop'],                   [ '0e','57']
  inst [ 'dconst_1','pop'],                   [ '0f','57']
  inst [ 'dconst_0','dconst_0','pop2'],       [ '0e','0e','58']
  inst [ 'dconst_0','dconst_1','pop2'],       [ '0e','0f','58']
  inst [ 'dconst_1','dconst_1','pop2'],       [ '0f','0f','58']
  inst [ 'dconst_1','dconst_0','pop2'],       [ '0f','0e','58']
  inst [ 'dup', 'pop'], ['59','57']
  inst [ 'dup', 'dup', 'pop'], ['59','57']

end




