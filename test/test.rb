require 'rubygems'
require 'sinatra'
require File.dirname(__FILE__) + '/../lib/sinatra/fancyviews'

set :haml, :format => :html5

get('/') { page :home }

__END__

@@layout
!!!
%head
  %title FancyTest
  = styles
%body
  = yield
  = scripts

@@home
:style
  #fancydiv
    :border 10px solid goldenrod
    :position fixed
    :top 20%
    :left 50%
    :width 600px
    :margin-left -300px
    :cursor pointer

#fancydiv= view :some_partial
  

@@some_partial
:style
  #fancy
    :font-family Helvetica
    :font-size 200px
    :font-weight bold
    :color black
    :margin 0
    :padding 10px
    :letter-spacing -4px

:script
  document.getElementById('fancy').onclick = function() { alert('Fancy click') } 

%h1#fancy Oooh! Fancy