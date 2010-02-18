#!/usr/bin/env ruby
# comm - file1 と file2 を比較する
#
# ruby comm.rb [OPTION]... FILE1 FILE2
#
require 'optparse'

visible1 = true
visible2 = true
visible3 = true

opt = OptionParser.new
opt.on("-1") {|v| visible1 = false}
opt.on("-2") {|v| visible2 = false}
opt.on("-3") {|v| visible3 = false}
opt.parse!(ARGV)

indent2 = ""
indent2 = "\t" if visible1

indent3 = ""
indent3 += "\t" if visible1
indent3 += "\t" if visible2

fname1 = ARGV[0]
fname2 = ARGV[1]

file1 = open(fname1)
file2 = open(fname2)

line1 = file1.gets
line2 = file2.gets

while (line1 != nil) or (line2 != nil)
    if (line1 == nil)
        order = 1
    elsif (line2 == nil)
        order = -1
    else
        order = line1 <=> line2
    end
    if (order == 0)
        print indent3 + line1 if visible3
    elsif (order > 0)
        print indent2 + line2 if visible2
    else
        print line1 if visible1
    end
    line2 = file2.gets if (order >= 0)
    line1 = file1.gets if (order <= 0)
end

file1.close
file2.close

