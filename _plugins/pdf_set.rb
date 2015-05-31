require 'rmagick'
require 'pathname'

module Jekyll
  class PDFSet < Liquid::Tag

    @pdf_path = nil
    @jpg_path = nil

    @class = nil
       @wrap_class = nil
       @wrap_tag = nil
       @container_class = nil
       @container_tag = nil
       @set_name = nil

       def initialize(tag_name, text, tokens)
         super

         @pdf_path = text.split(/\s+/)[0].strip
         @jpg_path = text.split(/\s+/)[1].strip

         @class = 'image'
            @wrap_class = 'image-item'
            @wrap_tag = 'li'
            @container_class = 'ul'
            @container_tag = 'thumbnail'
            @set_name = ''

            if text =~ /--class=(\S+)/i
              @class = text.match(/--class=(\S+)/i)[1]
               end
              if text =~ /--wrap-class=(\S+)/i
                @wrap_class = text.match(/--wrap-class=(\S+)/i)[1]
              end
              if text =~ /--wrap-tag=(\S+)/i
                @wrap_tag = text.match(/--wrap-tag=(\S+)/i)[1]
              end
              if text =~ /--container-class=(\S+)/i
                @container_class = text.match(/--container-class=(\S+)/i)[1]
              end
              if text =~ /--container-tag=(\S+)/i
                @container_tag = text.match(/--container-tag=(\S+)/i)[1]
              end
              if text =~ /--set-name=(\S+)/i
                @set_name = text.match(/--set-name=(\S+)/i)[1]
              end
            end

            def render(context)
              @site_url = context.environments.first["site"]["url"]
              pdf_paths = Dir.glob(File.join("#{@pdf_path}", "*.pdf")).map{ |path|
                Pathname.new(path)
              }

              source = "<#{@container_tag} class='#{@container_class}'>\n"
              source += "<h1>#{@set_name}</h1>"
              pdf_paths.each do |file|

                jpg_path = File.join("#{@jpg_path}", "#{file.basename.to_s.gsub('.pdf', '.jpg')}")

                if !File.exist?(jpg_path)
                  pic = Magick::Image.read("#{file}")
                  if pic[0] != nil
                    pic[0].write(jpg_path)
                  end
                end
                source += "<#{@wrap_tag} class='#{@wrap_class}'>\n"
                source += "<a href='#{@site_url}/#{file}'>\n"
                source += "<img src='#{@site_url}/#{jpg_path}' class='#{@class}'>\n"
                source += "</a>\n"
                source += "</#{@wrap_tag}>\n"
              end
              source += "</#{@container_tag}>\n"
            end
          end
       end
       Liquid::Template.register_tag('pdf_set', Jekyll::PDFSet)
