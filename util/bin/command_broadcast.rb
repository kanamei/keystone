# -*- coding: utf-8 -*-

# TODO 
# みしあげでおま

require 'rubygems'
require 'keystone'
require 'ipaddr'
require 'net/telnet'
require 'net/ssh'
require 'pp'

open("/tmp/command_broadcast.log.#{Time.now.usec}","w") do |f|
  f.puts "test"
end

LOGINID = "someuser"
LOGINPASS = "somepassword"

INPUT_MESSAGE_CMD = "input command you broadcast:"
INPUT_MESSAGE_IP = %|input ipaddress you broadcast(ex"192.168.1.13","192.168.1.0/24"):|

# TODO lvm 絡みも入れるべきかも
# ホワイトリストにすべき？
CANCEL_CMDS = %w|rm mv cp iptables fdisk dd| 

def ppp(message)
  print message
  STDOUT.flush
end
ppp INPUT_MESSAGE_IP
ipaddr = nil
STDIN.each_line do |line|
  line.strip!
  begin
    ipaddr = IPAddr.new line
    break
  rescue
    ppp INPUT_MESSAGE_IP
    next
  end
end

ppp INPUT_MESSAGE_CMD
cmd = nil
STDIN.each_line do |line|
  line.strip!
  if line.blank?
    ppp INPUT_MESSAGE_CMD
    next
  end
  cmd = line
  break
end

CANCEL_CMDS.each do |cancel_cmd|
  if cmd =~ /\A#{cancel_cmd}/
    puts "we can not run this command!!"
    exit
  end
end

puts "!! command you want to execute is below !!"
puts "#{cmd}"
ppp "?? are you sure to execute this??(y/N):"
STDIN.each_line do |line|
  line.chomp!
  break if line.downcase == 'y'
  puts "exit"
  exit
end

alive_servers = []
ipaddr.to_a.each do |ip|
  ping = "ping -c 1 -t 2 #{ip.to_s}"
  ret = `#{ping}`
  if ret =~ /100% packet loss/
    puts "#{ip.to_s} does not exits"
  else
    # OK な場合
    puts "#{ip.to_s} exits"
    alive_servers << ip
  end
end

results = []

alive_servers.each do |server|
  ret = ""
  begin
    ip = server.to_s
    pp ip
    puts "++ telnet ++"
    telnet = Net::Telnet.new("Host" => ip) {|c|} #print c}
    telnet.login(LOGINID, LOGINPASS) {|c|} #print c}
    telnet.cmd(cmd) {|c| ret = c}
    STDOUT.flush # <- これがないとここまで処理が来てることがわかりにくい
    # ログインセッションの終了
    telnet.cmd("exit") {|c|} #print c}
    telnet.close
    telnet_ok = true
#  rescue TimeoutError => e
  rescue TimeoutError => e
    puts e.message
  rescue Errno::ECONNREFUSED => e
    puts e.message
  rescue Errno::ENETUNREACH => e
    puts e.message
  rescue Errno::EACCES => e
    puts e.message
  end

  unless telnet_ok
    begin
      puts "++ ssh ++"
      Net::SSH.start(ip, LOGINID, :password => LOGINPASS) do |ssh|
        ret = (ssh.exec!(cmd))
      end    
    rescue Exception => e
    end
  end
  
  results << [ip,ret]
  puts ret
  sleep 1
end

pp results

open("/tmp/command_broadcast.log.#{Time.now.usec}","w") do |f|
  f.puts results.inspect
end

__END__
find /etc/lognotify/ -name "lognotify*.conf" -type f -exec cat {} \;



