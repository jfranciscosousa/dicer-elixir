require_relative "bot"
require "discordrb"
require "rufus-scheduler"

class CleanupScheduler
  attr_reader :scheduler

  def initialize(bot)
    @bot = bot
    @scheduler = Rufus::Scheduler.new

    scheduler.every "10m" do
      clear_messages
    end
  end

  private

  def clear_messages
    puts "LOG - clearing messages"

    @bot.servers.each do |_key, server|
      server.channels.each do |channel|
        BotUtils.clear_messages(channel)
        BotUtils.clear_commands(channel)
      end
    end
  end
end
