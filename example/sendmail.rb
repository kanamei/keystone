require 'rubygems'
require 'keystone'
require 'pit'

ENV["EDITOR"] = "vi" unless ENV.key?("EDITOR")
 
config = Pit.get("keystone_test", :require => {
        "smtp_addr" => "smtp_server_address",
        "mailto" => "mailto",
        "mailfrom" => "mailfrom"
})

@os = Keystone::Os.get()

Keystone::Mail::Send.send(
  config["mailfrom"],
  config["mailto"].split(","),
  "件名でおま",
  "本文で小間\nfrom #{@os.hostname}(#{@os.ip_address.join(" , ")})",
  {:smtp_addr=>config["smtp_addr"],:retry_cnt=>3})

