require 'optparse'

# どのフィールドを表示するかを判定するクラス
# カンマで区切る、
# '-M' は、'1-M'の意味
# 'N-' は、N番目から行の最後
class Fields

  def initialize(rule) 
    @ranges = []
    rule.split(",").each do |v|
      if /^(\d+)?(-)?(\d+)?$/ =~ v
        b = $1 ? $1.to_i : 1
        unless $2
          e = b
        else
          e = $3 ? $3.to_i : 10000
        end
        @ranges.push(b..e)
      end
    end
  end

  def include?(index) 
    @ranges.each do |r|
       return true if r.include?(index)
    end
    return false
  end 
end

$fields = nil
$delimiter = "\t"

opt = OptionParser.new
opt.on('-f VAL') {|v| $fields = Fields.new(v) }
opt.on('-d VAL') {|v| $delimiter = v }
opt.parse!(ARGV);

# １行ごとに処理
while line = ARGF.gets
  line.chomp!
  # 文字列を分割(split)
  s = line.split($delimiter, -1)
  if s.size == 1
    print line
  else
    has_prev = false
    s.each_index do |i|
      # どのフィールドを表示するかを判定
      if $fields.include?(i + 1)
        print $delimiter if has_prev
        print s[i]
        has_prev = true
      end
    end
  end
  print "\n"
end
