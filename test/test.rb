require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), '../lib/fancyviews')

get('/') { page :home }

__END__

@@layout
!!!
%html
  %head
    %title FancyTest
    = styles
    = script
  %body
    = yield

@@home
:styles
  #fancydiv
    :background red
    :color white

:script
  alert('hello');

#fancydiv red
= view :some_partial

@@some_partial
:styles
  #partial
    :background blue

:script
  alert('partial')

#partial this is a partial