class Webserver < Sinatra::Base
  set :views, File.dirname(__FILE__) + "/webserver/views"
  set :public_folder, File.dirname(__FILE__) + "/webserver/public"

  get "/" do
    @url = Discord.bot.invite_url

    erb :index
  end
end
