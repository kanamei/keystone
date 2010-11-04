# -*- coding: utf-8 -*-
require 'rubygems'
require 'keystone'
require "optparse"


class SampleBatch
  include Keystone::Batch::Base
  logger_name :l

  # 実行時に--helpでオプション一覧
  def main
    has_option = {}
    opts = option_parser
    opts.on("-v value") do |v|
      has_option[:v] = v
    end
    opts.on("-w who") do |v|
      has_option[:w] = v
    end

    execute() do
      begin
        sleep 10
        l.info "batch process01"
        l.info "who=#{has_option[:w]}"
        sleep 4
      rescue => e
        l.error e
      end
    end
  end
end

batch = SapmleBatch.new
batch.main