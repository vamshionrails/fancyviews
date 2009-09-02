require 'rubygems'
require 'sinatra'
require File.dirname(__FILE__) + '/../lib/sinatra/fancyviews'

set :haml, :format => :html4

get('/') { page :home }

__END__

@@layout
!!!
%head
  %title FancyTest
  = styles :media => "screen, projection"
%body
  = yield
  = scripts

@@home
:style
  body
    :background-color goldenrod

:script
  if (document.getElementsByTagName('style')[0].type != "text/css")
    alert("Style tag doesn't have type = 'text/css'");
  else if (document.getElementsByTagName('style')[0].media != "screen, projection")
    alert("Style tag doesn't have media = 'screen, projection'");
  else if (document.getElementsByTagName('script')[0].type != "text/javascript")
    alert("Script tag doesn't have type = 'text/javascript'");
  else
    alert("All good!");
