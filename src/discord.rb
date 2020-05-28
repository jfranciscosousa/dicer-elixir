module Discord
  Dotenv.load
  @bot = Discordrb::Bot.new(
    token: ENV["TOKEN"],
    client_id: ENV["CLIENT_ID"],
  )

  puts "This bot's invite URL is #{@bot.invite_url}"
  puts "Click on it to invite it to your server"

  def self.clear(event)
    Commands::Clear.new(bot: @bot, channel: event.channel).perform
  end

  def self.roll(event)
    rolls = Commands::RollDice.new(input: event.content).perform
    response = if rolls
                 "#{rolls} by #{event.author.username}"
               else
                 "Can't roll that my friend #{event.author.username}"
               end

    event.respond response
  end

  def self.roll_stats(event)
    response = Commands::RollStats.new.perform

    event.respond "#{event.author.username} your new stats are: #{response.join(' ')}"
  end

  @bot.message(with_text: "!clear") { |event| clear(event) }
  @bot.message(with_text: "!dicer clear") { |event| clear(event) }

  @bot.message(start_with: "!roll ") { |event| roll(event) }
  @bot.message(start_with: "!dicer roll ") { |event| roll(event) }

  @bot.message(with_text: "!roll_stats") { |event| roll_stats(event) }
  @bot.message(with_text: "!dicer roll_stats") { |event| roll_stats(event) }

  def self.run
    @bot.run(true)
  end

  def self.bot
    @bot
  end
end
