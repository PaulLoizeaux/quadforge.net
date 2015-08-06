# Title: Simple Video tag for Jekyll
# Author: Brandon Mathis http://brandonmathis.com
# Description: Easily output MPEG4 HTML5 video with a flash backup.
#
# Syntax {% video url/to/video [width height] [url/to/poster] %}
#
# Example:
# {% video http://site.com/video.mp4 720 480 http://site.com/poster-frame.jpg %}
#
# Output:
# <video width='720' height='480' preload='none' controls poster='http://site.com/poster-frame.jpg'>
#   <source src='http://site.com/video.mp4' type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'/>
# </video>
#
require 'streamio-ffmpeg'
require 'pathname'

module Jekyll

  class VideoTag < Liquid::Tag

    @videos = nil
    @poster = ''
    @poster_time = ''
    @height = ''
    @width = ''

    def initialize(tag_name, markup, tokens)
      @videos = markup.scan(/((https?:\/\/|\/)\S+\.(webm|ogv|mp4)\S*)/i).map(&:first).compact
      @poster = markup.scan(/((https?:\/\/|\/)\S+\.(png|gif|jpe?g)\S*)/i).map(&:first).compact.first
      @poster_time = markup.scan(/\s(\d\s)/i).map(&:first).compact
      @sizes  = markup.scan(/\s(\d\S+)/i).map(&:first).compact
      generate_thumbnail(@videos[0])
      super
    end

    def render(context)
      output = super
      @site_url = context.registers[:site].baseurl
      types = {
        '.mp4' => "type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'",
        '.ogv' => "type='video/ogg; codecs=theora, vorbis'",
        '.webm' => "type='video/webm; codecs=vp8, vorbis'"
      }
      if @videos.size > 0
        video =  "<video #{sizes} preload='metadata' controls #{poster}>"
        @videos.each do |v|
          video << "<source src='#{v}' #{types[File.extname(v)]}>"
        end
        video += "</video>"
      else
        "Error processing input, expected syntax: {% video url/to/video [url/to/video] [url/to/video] [width height] [url/to/poster] %}"
      end
    end

    def poster
      "poster='#{@poster}'" if @poster
    end

    def sizes
      attrs = "width='#{@sizes[0]}'" if @sizes[0]
      attrs += " height='#{@sizes[1]}'" if @sizes[1]
      attrs
    end

    def generate_thumbnail(video_path)
      if !File.exists?(@poster)
        video = FFMPEG::Movie.new("." + video_path)
        video.screenshot("." + @poster, seek_time: @poster_time[0].to_i)
      end
    end
  end
end

Liquid::Template.register_tag('video', Jekyll::VideoTag)
