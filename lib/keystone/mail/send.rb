# -*- coding: utf-8 -*-
require 'net/smtp'
require "nkf"

if __FILE__ ==$0
  $: << '../..'
  require 'keystone'
end

module Keystone
  module Mail
    class Send
      def self.sendmail(from, to, subject, body, host = "localhost", port = 25)
        body = <<EOT
From: #{from}
To: #{to.to_a.join(",\n ")}
Subject: #{NKF.nkf("-WMm0j", subject)}
Date: #{Time::now.strftime("%a, %d %b %Y %X %z")}
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

#{body}
EOT

        body = NKF.nkf("-Wj", body).force_encoding("ASCII-8BIT")

        Net::SMTP.start(host, port) do |smtp|
          smtp.send_mail body, from, to
        end
      end
    end
  end
end

