Gem::Specification.new do |s|
  s.name     = "fancyviews"
  s.version  = "0.3"
  s.date     = "2009-05-17"
  s.summary  = "Fancy Views"
  s.description  = "Fancy Views"
  s.email    = "myles@myles.id.au"
  s.authors  = ["Myles Byrne"]
  s.has_rdoc = false
  s.files    = %w[
Rakefile
fancyviews.gemspec
lib/fancyviews.rb
test/test.rb
]
  s.add_dependency("sinatra", [">= 0.9.1.1"])
end
