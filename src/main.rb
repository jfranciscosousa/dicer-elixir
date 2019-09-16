if $PROGRAM_NAME == __FILE__
  require "eventmachine"
  require "discordrb"
  require_relative "bot"
  require_relative "webserver"

  EM.run do
    Rack::Server.start(
      Port: ENV["PORT"] || 4567,
      app: WebServer.new,
      server: "thin",
      signals: false,
    )

    EM.defer do
      Bot.run
    end
  end

  puts "Bye!"
end
