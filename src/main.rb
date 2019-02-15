if $PROGRAM_NAME == __FILE__
  require "discordrb"
  require_relative "bot"
  require_relative "cleanup_scheduler"

  Bot.start

  puts "Bye!"
end
