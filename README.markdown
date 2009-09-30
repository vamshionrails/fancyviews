Fancyviews
==========

Fancyviews is a sinatra plugin for developers already using haml and sass.

The problem with the view layer of most codebases: adding code is quick and easy but removing that same code two weeks later is fraught with peril.

This asymmetry is the unfortunate result of organizing view code by _type_ instead of _use_. The HTML/DOM code goes in one bucket and the styles & javascript get their own buckets. When the time comes to make a change that requires modification to all three types of view code, the specific lines must be located in each bucket.

Fancyviews flips this around and allows you to organize your view code by _use_ but renders it to the browser as if it was organized by type. You put all the code in one view file, nesting your javascript and sass beneath the `script` and `style` haml filters:

    # fancy.haml    
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

And now you use the `view` method wherever you want include this:

    # anywhere.haml
    // ... some other code
    view :fancy
    // ... more codez

The haml will be rendered and included, just like normal partial rendering, but the styles and scripts will be captured by fancy goats. Then somewhere in your layout you steal them back from those sneaky goats with the `styles` and `scripts` (note the plurals) methods:

    # layout.haml
    %head
      = styles
    %body
      ...
      = scripts

For syntax highlighting in textmate, use this haml bundle: http://github.com/quackingduck/ruby-haml.tmbundle/tree/master and for sass use this one:
http://github.com/quackingduck/ruby-sass-tmbundle/tree/master

The `style` method can also import other sass files present in the views directory:

    = styles(:import => :base)