if $PROGRAM_NAME == __FILE__
  require "rubygems"
  require "bundler/setup"
  Bundler.require(:default)

  Dotenv.load

  loader = Zeitwerk::Loader.for_gem
  loader.setup

  EM.run do
    Rack::Server.start(
      Port: ENV["PORT"] || 4567,
      app: Webserver.new,
      server: "thin",
      signals: false,
    )

    EM.defer do
      Discord.run
    end
  end

  puts "Bye!"
end
