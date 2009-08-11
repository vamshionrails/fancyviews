require 'sinatra/base'
require 'haml'
require 'sass'

module Sinatra
  
  module StyleFilter
    include Haml::Filters::Base

    def compile(precompiler, text)
      precompiler.send :push_silent, %(fancyviews.include_style(fancyviews.view_name, #{text.inspect}))
    end
  end
  Haml::Filters.defined['style'] = StyleFilter
  
  module ScriptFilter
    include Haml::Filters::Base

    def compile(precompiler, text)
      precompiler.send :push_silent, %(fancyviews.include_script(fancyviews.view_name, #{text.inspect}))
    end
  end
  Haml::Filters.defined['script'] = ScriptFilter
  
  class FancyViews
    
    # current view
    attr_accessor :view_name
    
    def initialize(app)
      @app = app
    end
    
    def include_style(name, sass)
      included_styles << [name, sass] unless included_styles.detect { |s| s == [name, sass] }
    end
    
    def included_styles
      @included_styles ||= []
    end
    
    def include_script(name, js)
      included_scripts << [name, js] unless included_scripts.detect { |s| s == [name, js] }
    end

    def included_scripts
      @included_scripts ||= []
    end
    
  end
  
  module FancyHelpers
    
    # use this instead of `haml` when rendering a template, unlike the haml
    # method, layout is false by default
    def view(name, options = {})
      parent_view = fancyviews.view_name.to_s
      fancyviews.view_name = name.to_s
      options[:layout] = false unless options.has_key?(:layout)
      rendered = haml(name, options)
      fancyviews.view_name = parent_view
      rendered
    end
    
    # same as `view` but has layout by default
    def page(name, options = {})
      options[:layout] = true unless options.has_key?(:layout)
      view(name, options)
    end
    
    # renders all the styles captured by the :style filter
    def styles(options = {})
      imported = options.has_key?(:import) ?
        File.read("#{self.options.views}/#{options[:import]}.sass") : ''

      rendered_styles = fancyviews.included_styles.map do |name, sass| 
        # would be nice if construction took an :offest to go along with the :filename
        eng = Sass::Engine.new(imported + "\n" + sass, :attribute_syntax => :normal)
        "\n/* -- #{name} -- */\n" + eng.render
      end.join
      
      capture_haml { haml_tag(:style, rendered_styles) }.strip
    end
    
    # renders all the scripts captured by the :script filter
    def scripts
      scripts = fancyviews.included_scripts.map do |name, js|
        "\n/* -- #{name} -- */\n" + js
      end.join
      capture_haml { haml_tag(:script, scripts) }.strip
    end
    
    def fancyviews
      @fancyviews ||= FancyViews.new(self)
    end
  
  end

  helpers FancyHelpers
end