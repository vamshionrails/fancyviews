gem "sr-mg", "0.0.2"

task :default => :test

desc "Run example test app"
task :test do
  dir = File.dirname(__FILE__)
  system "cd #{dir} && ruby test/test.rb -p 2222"
end

begin
  require "mg"
  MG.new("fancyviews.gemspec")
rescue LoadError
end
