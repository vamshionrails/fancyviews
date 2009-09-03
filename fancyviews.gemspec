Gem::Specification.new do |s|
  s.name     = "fancyviews"
  s.rubyforge_project = 'fancyviews'
  s.version  = "1.3"
  s.summary  = "Fancy Views"
  s.description  = "Fancy Views"
  s.email    = "myles@myles.id.au"
  s.authors  = ["Myles Byrne"]
  s.has_rdoc = false
  s.require_paths = ["lib"]
  s.files    = %w[
Rakefile
fancyviews.gemspec
lib/sinatra/fancyviews.rb
test/html4.rb
test/html5.rb
]
  s.add_dependency("sinatra", [">= 0.9.1.1"])
  s.add_dependency("haml", [">= 2.2"])
end
