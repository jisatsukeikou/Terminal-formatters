#!/usr/bin/env ruby

require "/home/pieceoftrash/script/terminal-formatter/terminal_formatter.rb"

include TerminalFormatter

TerminalFormatter.images_path  = "/home/pieceoftrash/.xmonad/xbm"
scripts_path = "/home/pieceoftrash/script/conky-trackers/"

conky_config = Conky::Config.new(
  background: false,
  double_buffer: true,
  use_xft: true,
  override_utf8_locale: true,
  no_buffers: true,
  own_window: true,
  own_window_transparent: true,
  own_window_argb_visual: true,
  border_width: 0,
  cpu_avg_samples: 2,
  gap_x: -500,
  gap_y: 28,
  draw_shades: false,
  maximum_width: 860,
  net_avg_samples: 2,
  update_interval: 2.0,
  font: "'Hack:size=9'",
  alignment: "'top_middle'",
  default_color: "'211F2C'",
  own_window_class: "'Conky'",
  own_window_type: "'desktop'",
  own_window_hints: "'undecorated,below,sticky,skip_taskbar,skip_pager'"
)

conky_text = Conky::Text.new do |text|
  text << Conky.font("Font Awesome", size: 16) { "" }
  text << Conky.br
  text << Conky.execi(10, File.join(scripts_path, "gitlab", "gitlab.rb"))
  text << Conky.br
  text << Conky.br
  text << Conky.font("Font Awesome", size: 16) { "" }
  text << Conky.br
  text << Conky.execi(10, File.join(scripts_path, "redmine", "redmine.rb"))
end

puts conky_config
puts
puts conky_text
