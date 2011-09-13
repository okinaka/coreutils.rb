#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# grep モドキの実装

require 'optparse'
require 'kconv'

regexp = '';
skip = false;
OptionParser.new do |opt|
  opt.on('-e VAL', '--regexp VAL') {|v| regexp = v.toutf8}
  opt.on('-l', '--files-with-matches') {|v| skip = true }
  opt.parse!(ARGV)
end
regexp = ARGV.shift if regexp == '' and ARGV.size > 0
rule = Regexp.new(regexp)
dispFilename = (ARGV.size > 1)
while line = ARGF.gets
  next unless rule =~ line.toutf8
  if skip
    puts ARGF.filename
    ARGF.skip
  elsif dispFilename
    print ARGF.filename + ':'+ line
  else
    print line
  end
end

