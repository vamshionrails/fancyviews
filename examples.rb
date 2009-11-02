require 'exemplor'
require 'fancypath'
require 'rack/test'

# http://gist.github.com/58009
def Clip(str)
  return str unless str.include?("\n")
  first_indent = str.match(/\n\s*/).to_s
  str.gsub( first_indent, "\n" ).strip
end

class TestApp
  
  attr_reader :path
  
  def initialize(path)
    @path = path
  end
  
  def views_path; path.join('views').create end  
  
  def view(name, src)
    views_path.join(name).write Clip(src)
  end
  
  def test_body
    require 'shellwords'
    # rack test prints errors to stderr twice ... not sure why
    test = Clip %{
    require 'app'
    set :environment, :test
    
    require 'rack/test'
    puts Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application)).get('/test').body
    }
    
    `ruby -I#{path} -e #{test.split("\n").join(";").shellescape}`
  end
  
end

eg.helpers do
  
  def create_app(app_src)
    app = TestApp.new Fancypath(__FILE__).dir.join('example_app')
    app.path.join('app.rb').write Clip(app_src)
    app
  end
  
end

eg "multiple libraries can be imported with #styles()" do
  app = create_app %{
  require 'sinatra'
  require File.dirname(__FILE__) + '/../lib/sinatra/fancyviews'
  
  get('/test') { page :test }
  }
  app.view 'lib1.sass', %{
  =red
    :background red
  }
  app.view 'lib2.sass', %{
  =blue
    :background blue
  }
  app.view 'test.haml', %{
  :style
    .red
      +red
    .blue
      +blue
  }
  app.view 'layout.haml', %{
  = styles :import => %w(lib1 lib2)
  }
  app.test_body
end