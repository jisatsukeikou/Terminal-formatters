#!/usr/bin/env ruby

require "/home/pieceoftrash/scripts/terminal-formatters/terminal_formatter.rb"

include TerminalFormatter

TerminalFormatter.images_path  = "/home/pieceoftrash/.xmonad/xbm"
scripts_path = "/home/pieceoftrash/scripts/conky"

conky_config = Conky::Config.new(
  background: false,
  out_to_console: true,
  out_to_x: false,
  no_buffers: true,
  update_interval: 1.0,
  uppercase: false,
  use_spacer: 'none',
  short_units: true,
  pad_percents: 2
)

conky_text = Conky::Text.new do |text|
  text << Dzen.fg("orange") do
    Dzen.image "bat_full_01.xbm"
  end
  text << Conky.space
  text << Conky.run("battery_short")
  text << Conky.space(3) << Conky.nbr
  
  text << Dzen.fg("orange") do
    Dzen.image "cpu.xbm"
  end
  text << Conky.space(2)
  text << Conky.run("cpu") << "%"
  text << Conky.space(2) << Conky.nbr

  text << Conky.space(2)
  text << Dzen.fg("orange") do
    Dzen.image "mem.xbm"
  end
  text << Conky.space(2)
  text << Conky.run("mem") + ?/ + Conky.run("memmax")
  text << Conky.space(3) << Conky.nbr

  text << Conky.space(2)
  text << Dzen.fg("orange") do
    Dzen.image("diskette.xbm")
  end
  text << Conky.space
  text << Dzen.fg("cyan") do
    Conky.space << "/" << Conky.space
  end
  text << Conky.run("fs_free", "/") << Conky.space << "(#{Conky.run("fs_free_perc", "/")}%)"
  text << Conky.space
  text << Conky.nbr

  text << Conky.space(2)
  text << Dzen.fg("orange") do
    Dzen.image("net_wired.xbm")
  end
  text << Conky.space
  text << Dzen.fg("cyan") do
    Conky.run("execi", 300, File.join(scripts_path, "net.sh"), "dev")
  end
  text << Conky.space
  text << Dzen.fg("grey") do
    Conky.run("execi", 300, File.join(scripts_path, "net.sh"), "ip")
  end
  text << Conky.space
  text << "[#{Conky.run("execi", 300, "curl", "http://ipinfo.io/ip")}]"
  text << Conky.space(2)
  text << Conky.nbr

  text << Conky.space(2)
  text << Dzen.fg("orange") do
    Conky.run "time", "%R"
  end
end

puts conky_config
puts
puts conky_text
