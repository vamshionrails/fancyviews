Fancyviews
==========

Two haml filters and two helper methods. First require fancyviews:

    require 'sinatra/fancyviews'

Now you use the `page` method instead of the `haml` method, so replace:

    haml :myview

with

    page :myview


Then inside you views, replace the `haml` method with the `view` method

    %h1 Not Fancy
    = haml :subview, :layout => falss

to:

    %h1 Fancy
    = view :subview


Now you can use the `:styles` and `:script` filters which work like rail's `content_for` method. They squirrel away their contents and allow you to render them somewhere in the layout simply by calling the `styles` and `script` helper methods. See `test/test.rb` for an example.