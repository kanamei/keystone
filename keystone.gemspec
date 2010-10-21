# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{keystone}
  s.version = "0.0.29"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["paco"]
  s.date = %q{2010-09-02}
  s.description = %q{oreore library}
  s.email = %q{paco.jp@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "README",
     "Rakefile",
     "VERSION",
     "doc/classes/Dir.html",
     "doc/classes/Dir.src/M000003.html",
     "doc/classes/FlagSetMaker.html",
     "doc/classes/FlagSetMaker.src/M000018.html",
     "doc/classes/FlagSetMaker/FlagSet.html",
     "doc/classes/FlagSetMaker/FlagSet.src/M000019.html",
     "doc/classes/FlagSetMaker/FlagSet.src/M000020.html",
     "doc/classes/FlagSetMaker/FlagSet.src/M000021.html",
     "doc/classes/FlagSetMaker/FlagSet.src/M000022.html",
     "doc/classes/FlagSetMaker/Flags.html",
     "doc/classes/FlagSetMaker/Flags.src/M000023.html",
     "doc/classes/FlagSetMaker/Flags.src/M000024.html",
     "doc/classes/FlagSetMaker/Flags.src/M000025.html",
     "doc/classes/FlagSetMaker/Flags.src/M000026.html",
     "doc/classes/FlagSetMaker/Flags.src/M000027.html",
     "doc/classes/FlagSetMaker/Flags.src/M000029.html",
     "doc/classes/FlagSetMaker/Flags.src/M000030.html",
     "doc/classes/FlagSetMaker/Flags.src/M000031.html",
     "doc/classes/FlagSetMaker/Flags.src/M000032.html",
     "doc/classes/FlagSetMaker/Flags.src/M000033.html",
     "doc/classes/Hoge.html",
     "doc/classes/Keystone.html",
     "doc/classes/Keystone/Base.html",
     "doc/classes/Keystone/Base.src/M000054.html",
     "doc/classes/Keystone/Base.src/M000055.html",
     "doc/classes/Keystone/Base.src/M000056.html",
     "doc/classes/Keystone/Base.src/M000057.html",
     "doc/classes/Keystone/Base.src/M000058.html",
     "doc/classes/Keystone/Batch.html",
     "doc/classes/Keystone/Batch/Base.html",
     "doc/classes/Keystone/Batch/Base.src/M000052.html",
     "doc/classes/Keystone/Batch/Base.src/M000053.html",
     "doc/classes/Keystone/CoreExt.html",
     "doc/classes/Keystone/Mail.html",
     "doc/classes/Keystone/Mail/Send.html",
     "doc/classes/Keystone/Mail/Send.src/M000034.html",
     "doc/classes/Keystone/Mail/Send.src/M000035.html",
     "doc/classes/Keystone/Mail/Send.src/M000036.html",
     "doc/classes/Keystone/Os.html",
     "doc/classes/Keystone/Os.src/M000037.html",
     "doc/classes/Keystone/Os.src/M000038.html",
     "doc/classes/Keystone/Os/AbstractOs.html",
     "doc/classes/Keystone/Os/AbstractOs.src/M000046.html",
     "doc/classes/Keystone/Os/AbstractOs.src/M000047.html",
     "doc/classes/Keystone/Os/AbstractOs.src/M000048.html",
     "doc/classes/Keystone/Os/AbstractOs.src/M000049.html",
     "doc/classes/Keystone/Os/AbstractOs.src/M000050.html",
     "doc/classes/Keystone/Os/AbstractOs.src/M000051.html",
     "doc/classes/Keystone/Os/Centos.html",
     "doc/classes/Keystone/Os/Darwin.html",
     "doc/classes/Keystone/Os/Darwin.src/M000039.html",
     "doc/classes/Keystone/Os/Linux.html",
     "doc/classes/Keystone/Os/Linux.src/M000045.html",
     "doc/classes/Keystone/Os/Osx.html",
     "doc/classes/Keystone/Os/Unix.html",
     "doc/classes/Keystone/Os/Unix.src/M000040.html",
     "doc/classes/Keystone/Os/Unix.src/M000041.html",
     "doc/classes/Keystone/Os/Unix.src/M000042.html",
     "doc/classes/Keystone/Os/Unix.src/M000043.html",
     "doc/classes/Keystone/Os/Unix.src/M000044.html",
     "doc/classes/Keystone/Rails.html",
     "doc/classes/Keystone/StringUtil.html",
     "doc/classes/Keystone/StringUtil.src/M000059.html",
     "doc/classes/Keystone/StringUtil.src/M000060.html",
     "doc/classes/Keystone/StringUtil.src/M000061.html",
     "doc/classes/Keystone/StringUtil.src/M000062.html",
     "doc/classes/Keystone/StringUtil.src/M000063.html",
     "doc/classes/Object.html",
     "doc/classes/Object.src/M000012.html",
     "doc/classes/Object.src/M000013.html",
     "doc/classes/Object.src/M000014.html",
     "doc/classes/Object.src/M000015.html",
     "doc/classes/Object.src/M000016.html",
     "doc/classes/Object.src/M000017.html",
     "doc/classes/Tempfile.html",
     "doc/classes/Tempfile.src/M000011.html",
     "doc/classes/TestCoreExt.html",
     "doc/classes/TestCoreExt.src/M000009.html",
     "doc/classes/TestCoreExt.src/M000010.html",
     "doc/classes/TestStringUtilBase.html",
     "doc/classes/TestStringUtilBase.src/M000004.html",
     "doc/classes/TestStringUtilBase.src/M000005.html",
     "doc/classes/TestStringUtilBase.src/M000006.html",
     "doc/classes/TestStringUtilBase.src/M000007.html",
     "doc/classes/TestStringUtilBase.src/M000008.html",
     "doc/classes/Uri.html",
     "doc/classes/Uri.src/M000001.html",
     "doc/classes/Uri.src/M000002.html",
     "doc/created.rid",
     "doc/files/example/batch_sample_rb.html",
     "doc/files/example/os_rb.html",
     "doc/files/example/string_util_rb.html",
     "doc/files/lib/keystone/base_rb.html",
     "doc/files/lib/keystone/batch/base_rb.html",
     "doc/files/lib/keystone/batch_rb.html",
     "doc/files/lib/keystone/core_ext/array_rb.html",
     "doc/files/lib/keystone/core_ext/blank_rb.html",
     "doc/files/lib/keystone/core_ext/dir_rb.html",
     "doc/files/lib/keystone/core_ext/object_rb.html",
     "doc/files/lib/keystone/core_ext/tempfile_rb.html",
     "doc/files/lib/keystone/core_ext/uri_rb.html",
     "doc/files/lib/keystone/core_ext_rb.html",
     "doc/files/lib/keystone/mail/send_rb.html",
     "doc/files/lib/keystone/mail_rb.html",
     "doc/files/lib/keystone/os/abstract_os_rb.html",
     "doc/files/lib/keystone/os/centos_rb.html",
     "doc/files/lib/keystone/os/darwin_rb.html",
     "doc/files/lib/keystone/os/linux_rb.html",
     "doc/files/lib/keystone/os/osx_rb.html",
     "doc/files/lib/keystone/os/unix_rb.html",
     "doc/files/lib/keystone/os_rb.html",
     "doc/files/lib/keystone/string_util_rb.html",
     "doc/files/lib/keystone_rb.html",
     "doc/files/test/test_core_ext_rb.html",
     "doc/files/test/test_string_util_rb.html",
     "doc/files/vendor/flag_set_maker_rb.html",
     "doc/files/vendor/moji_rb.html",
     "doc/fr_class_index.html",
     "doc/fr_file_index.html",
     "doc/fr_method_index.html",
     "doc/index.html",
     "doc/rdoc-style.css",
     "example/batch_sample.rb",
     "example/os.rb",
     "example/sendmail.rb",
     "example/string_util.rb",
     "keystone.gemspec",
     "lib/keystone.rb",
     "lib/keystone/base.rb",
     "lib/keystone/batch.rb",
     "lib/keystone/batch/base.rb",
     "lib/keystone/core_ext.rb",
     "lib/keystone/core_ext/array.rb",
     "lib/keystone/core_ext/blank.rb",
     "lib/keystone/core_ext/dir.rb",
     "lib/keystone/core_ext/ipaddr.rb",
     "lib/keystone/core_ext/object.rb",
     "lib/keystone/core_ext/tempfile.rb",
     "lib/keystone/core_ext/uri.rb",
     "lib/keystone/mail.rb",
     "lib/keystone/mail/address.rb",
     "lib/keystone/mail/content_type.rb",
     "lib/keystone/mail/message.rb",
     "lib/keystone/mail/message_factory.rb",
     "lib/keystone/mail/message_iso2022jp.rb",
     "lib/keystone/mail/message_sjis.rb",
     "lib/keystone/mail/receive.rb",
     "lib/keystone/mail/send.rb",
     "lib/keystone/os.rb",
     "lib/keystone/os/abstract_os.rb",
     "lib/keystone/os/centos.rb",
     "lib/keystone/os/darwin.rb",
     "lib/keystone/os/linux.rb",
     "lib/keystone/os/osx.rb",
     "lib/keystone/os/unix.rb",
     "lib/keystone/string_util.rb",
     "test/test_core_ext.rb",
     "test/test_string_util.rb",
     "util/README",
     "util/bin/command_broadcast.rb",
     "util/bin/disk_size_check.rb",
     "util/bin/notice",
     "util/bin/ve2tar.rb",
     "vendor/flag_set_maker.rb",
     "vendor/moji.rb"
  ]
  s.homepage = %q{http://github.com/kanamei/keystone}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{oreore library}
  s.test_files = [
    "test/test_core_ext.rb",
     "test/test_string_util.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
