require 'optparse'

class DefaultSort
  def compare(a, b)
    a <=> b
  end
end

class NumericSort
  def compare(a, b)
    /^(\d*|\s+\d+)(.*)$/ =~ a
    a1, a2 = $1, $2
    /^(\d*|\s+\d+)(.*)$/ =~ b
    b1, b2 = $1, $2

    r1 = a1.to_i <=> b1.to_i
    if r1 != 0
      r1
    else
      a2 <=> b2
    end
  end
end

reverse = 1

sort = DefaultSort.new

opt = OptionParser.new
opt.on("-n", "--numeric-sort") {|v| sort = NumericSort.new}
opt.on("-r", "--reverse") {|v| reverse = -1}
opt.parse!(ARGV)

ARGF.sort {|a, b| sort.compare(a, b) * reverse}.each {|v| print v}

