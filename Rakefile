
# TODO make all nicer

$:.unshift "lib"

#require 'lib/keystone'

# task :build do
#   sh 'rm -f kanamei-keystone-#{Keystone::VERSION}.gem'
#   sh "gem build keystone.gemspec"
#   sh "gem install kanamei-keystone-#{Keystone::VERSION}.gem"
# end

task :build do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gemspec|
      gemspec.name = "keystone"
      gemspec.summary = "oreore library"
      gemspec.email = "paco.jp@gmail.com"
      gemspec.homepage = "http://github.com/kanamei/keystone"
      gemspec.description = "oreore library"
      gemspec.authors = ["paco"]
    end
  rescue LoadError
    puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
  end  
end

