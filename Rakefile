task :default => :test

%w(html4 html5).each do |version|
  desc "Run example test app for #{version}"
  task "test_#{version}" do
    dir = File.dirname(__FILE__)
    system "cd #{dir} && ruby test/#{version}.rb -p 2222"
  end
end

begin
  gem "sr-mg", "0.0.2"
  require "mg"
  MG.new("fancyviews.gemspec")
rescue LoadError
end
