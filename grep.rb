#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# grep モドキの実装

require 'optparse'
require 'kconv'

regexp = '';
OptionParser.new {|opt|
  opt.on('-e VAL', '--regexp VAL') {|v| regexp = v.toutf8}
  opt.parse!(ARGV)
}
regexp = ARGV.shift if regexp == '' and ARGV.size > 0
rule = Regexp.new(regexp)
dispFilename = (ARGV.size > 1)
while line = ARGF.gets
  next unless rule =~ line.toutf8
  print ARGF.filename + ':' if dispFilename
  print line
end

