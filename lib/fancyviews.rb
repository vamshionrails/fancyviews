require 'sinatra/base'
require 'haml'
require 'sass'

module Sinatra
  
  module FancyViews
    
    # use this instead of `haml` when rendering a template, unlike the haml
    # method, layout is false by default
    def view(name, options = {})
      parent_view = @view_name
      @view_name = name.to_s
      options[:layout] = false unless options.has_key?(:layout)
      rendered = haml(name, options)
      @view_name = parent_view
      rendered
    end
    
    # same as `view` but has layout by default
    def page(name, options = {})
      options[:layout] = true unless options.has_key?(:layout)
      view(name, options)
    end
    
    # use the :styles filter to define styles and the `styles` method to
    # render them
    
    def styles(options = {})
      imported = options.has_key?(:import) ?
        File.read("#{self.options.views}/#{options[:import]}.sass") : ''

      rendered_styles = included_styles.map do |name, sass| 
        # would be nice if construction took an :offest to go along with the :filename
        eng = Sass::Engine.new(imported + "\n" + sass, :attribute_syntax => :normal)
        "\n/* -- #{name} -- */\n" + eng.render
      end.join
      
      capture_haml { haml_tag(:style, rendered_styles, :type => 'text/css') }.strip
    end
    
    def script
      scripts = included_scripts.map do |name, js|
        "\n/* -- #{name} -- */\n" + js
      end.join
      capture_haml { haml_tag(:script, scripts, :type => 'text/javascript') }.strip
    end
    
    # private
    
    def view_name
      @view_name
    end
    
    module StyleFilter
      include Haml::Filters::Base

      def compile(precompiler, text)
        precompiler.send :push_silent, %(include_styles(view_name, #{text.inspect}))
      end
    end
    Haml::Filters.defined['styles'] = StyleFilter
    
    module ScriptFilter
      include Haml::Filters::Base

      def compile(precompiler, text)
        precompiler.send :push_silent, %(include_scripts(view_name, #{text.inspect}))
      end
    end
    Haml::Filters.defined['script'] = ScriptFilter
    
    def include_styles(name, sass)
      included_styles << [name, sass] unless included_styles.detect { |s| s == [name, sass] }
    end

    def included_styles
      @included_styles ||= []
    end
    
    def include_scripts(name, js)
      included_scripts << [name, js] unless included_scripts.detect { |s| s == [name, js] }
    end

    def included_scripts
      @included_scripts ||= []
    end
    
  end

  helpers FancyViews
end