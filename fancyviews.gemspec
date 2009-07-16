Gem::Specification.new do |s|
  s.name     = "fancyviews"
  s.version  = "0.5"
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
test/test.rb
]
  s.add_dependency("sinatra", [">= 0.9.1.1"])
end
