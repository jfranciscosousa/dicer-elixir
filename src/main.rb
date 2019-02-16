if $PROGRAM_NAME == __FILE__
  require "discordrb"
  require_relative "bot"
  require_relative "cleanup_scheduler"
  require_relative "webserver"

  Process.fork do
    Bot.start
  end

  Process.fork do
    puts "WebServer!"

    WebServer.run!
  end

  Process.wait

  puts "Bye!"
end
