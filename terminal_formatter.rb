module TerminalFormatter
  attr_accessor :images_path

  @@images_path = ""

  module Conky
    extend self

    def run(command, *params)
      if params.nil?
        "$#{command}"
      else
        "${#{command} #{params.join ' '}}"
      end
    end

    def execi(interval, command)
      run("execi", interval, command)
    end

    def execpi(interval, command)
      run("execpi", interval, command)
    end

    def font(font_name, params = {})
      params_string = params
        .map do |k, v| ?: + k.to_s + ?= + v.to_s end
        .reduce(&:+)
      opening = "${font #{font_name}#{params_string}}"
      closing = "${font}"

      opening << yield(String.new) << closing
    end

    def color(color_hex, &block)
      opening = "${color #{color_hex}}"
      closing = "${color}"

      opening << yield(String.new) << closing
    end

    def align(direction, offset = 0)
      direction_tag = case direction
                      when :center then "alignc"
                      when :right then "alignr"
                      else "alignl"
                      end
      "${#{direction_tag} #{offset}}"
    end

    def offset(offset)
      "${offset #{offset}}"
    end

    def space(space_count = 1)
      res = ""
      space_count.times do res += " " end
      res
    end

    def br
      ?\n
    end

    def nbr()
      ?\\ + ?\n
    end

    class Config
      def initialize(hash)
        @config_string = String.new
        opening = "conky.config = {" + ?\n
        closing = ?\n + "};"

        @config_string << opening
        @config_string << hash
          .map { |k, v| "#{k} = #{v}" }
          .reduce { |s1, s2| "#{s1},\n#{s2}" }
        @config_string << closing
      end

      def to_s
        @config_string
      end
    end

    class Text
      def initialize
        opening = "conky.text = [[" + ?\n
        closing = ?\n + "]];"

        @text = String.new
        @text << opening << yield(String.new) << closing
      end

      def to_s
        @text
      end
    end
  end

  module Dzen
    extend self

    def fg(color, &block)
      opening = "^fg(#{color})"
      closing = "^fg()"

      opening << yield(String.new) << closing
    end

    def image(image_name)
      "^i(#{TerminalFormatter.images_path}/#{image_name})"
    end
  end
end
