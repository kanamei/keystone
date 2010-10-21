require 'rubygems'
require 'keystone'
require "optparse"

include Keystone::Batch::Base

# 実行時に--helpでオプション一覧

has_option = {}
opts = option_parser
opts.on("-v value") do |v|
  has_option[:v] = v
end
opts.on("-w who") do |v|
  has_option[:w] = v
end

execute() do
  sleep 10
  info "batch process01"
  info "who=#{has_option[:w]}"
  sleep 4
  raise 'error occur'
end