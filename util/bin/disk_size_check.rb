#!/usr/bin/ruby

require 'rubygems'
require 'keystone'
require 'pit'

include Keystone::Batch::Base

ENV["EDITOR"] = "vi" unless ENV.key?("EDITOR")

config = Pit.get("disk_size_check", :require => {
        "smtp_addr" => "smtp_server_address",
        "mailto" => "mailto",
        "mailfrom" => "mailfrom"
})

SMTP_ADDR = config["smtp_addr"]
MAIL_TO = [config["mailto"]]
ERROR_MAIL_TO = MAIL_TO
MAIL_FROM = config["mailfrom"]

@os = Keystone::Os.get()

def send_alert_mail(additional_body = "")
  title = 'disk size alert'
  body  = <<-BODY
disk size alert at #{@os.hostname}(#{@os.ip_address.join(" , ")})
#{@df_result}
#{additional_body}
BODY

  Keystone::Mail::Send.send(
    MAIL_FROM,
    MAIL_TO,
    title,
    body,
    {:smtp_addr=>SMTP_ADDR,:retry_cnt=>3}
  )
end

execute() do
  limit = 80
  limit = Integer(ARGV[0]) if ARGV.size > 0

  @df_result = @os.disk
  @df_result.gsub(/(\d+)%/){|s|
    if $1.to_i >= limit
      warn 'log size alert'
      send_alert_mail
      break
    end
  }
end

