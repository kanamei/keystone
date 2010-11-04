# -*- coding: utf-8 -*-

$LOAD_PATH << "../lib/"

require 'keystone'
require "optparse"
require 'pit'


ENV["EDITOR"] = "vi" unless ENV.key?("EDITOR")

class Batch
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
    
    config = Pit.get("keystone_test", :require => {
            "smtp_addr" => "smtp_server_address",
            "mailto" => "mailto",
            "mailfrom" => "mailfrom"
    })    

    execute(:error_mail_to=>config["mailto"]) do
      # begin
        l.info "batch process01"
        l.info "who=#{has_option[:w]}"
        l.warn "this is warning"
        raise "error occured manually エラーが発生しましたがなにか？？？？"
      # rescue => e
      #   l.error e
      # end
    end
  end
end

b = Batch.new
b.main