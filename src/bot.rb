require "dotenv"
require "discordrb"
require_relative "commands/clear"
require_relative "commands/roll_dice"
require_relative "commands/roll_stats"

module Bot
  Dotenv.load
  @bot = Discordrb::Bot.new(
    token: ENV["TOKEN"],
    client_id: ENV["CLIENT_ID"],
  )

  puts "This bot's invite URL is #{@bot.invite_url}"
  puts "Click on it to invite it to your server"

  @bot.message(with_text: "!clear") do |event|
    Commands::Clear.new(bot: @bot, channel: event.channel).perform
  end

  @bot.message(start_with: "!roll ") do |event|
    rolls = Commands::RollDice.new(input: event.content).perform
    response = if rolls
                 "#{rolls} by #{event.author.username}"
               else
                 "Can't roll that my friend #{event.author.username}"
               end

    event.respond response
  end

  @bot.message(with_text: "!roll_stats") do |event|
    response = Commands::RollStats.new.perform

    event.respond "#{event.author.username} your new stats are: #{response.join(" ")}"
  end

  def self.start
    @bot.run
  end

  def self.bot
    @bot
  end
end
