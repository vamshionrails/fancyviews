task :default => :test

%w(html4 html5).each do |version|
  desc "Run example test app for #{version}"
  task "test_#{version}" do
    dir = File.dirname(__FILE__)
    system "cd #{dir} && ruby test/#{version}.rb -p 2222"
  end
end

task :examples do
  ruby 'examples.rb'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name     = "fancyviews"
    s.homepage = "http://github.com/quackingduck/fancyviews"
    s.summary  = "A views module for sinatra"
    s.email    = "myles@myles.id.au"
    s.authors  = ["Myles Byrne"]
    s.has_rdoc = false
    
    s.add_dependency "sinatra", ">= 0.9.1.1"
    s.add_dependency "haml", ">= 2.2"
    
    s.add_development_dependency "exemplor", ">= 2000.0.0"
    s.add_development_dependency "fancypath", ">= 0.5.13"
    s.add_development_dependency "rack-test", ">= 0.4.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Install jeweler to build gem"
end