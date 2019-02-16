require "sinatra/base"
require "erb"
require_relative "bot"

class WebServer < Sinatra::Base
  set :views, File.dirname(__FILE__) + "/views"

  get "/" do
    @url = Bot.bot.invite_url

    erb :index
  end
end
