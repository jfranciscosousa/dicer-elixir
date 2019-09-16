COMMANDS = ["!roll", "!roll_stats", "!clear", "!dicer roll", "!dicer roll_stats", "!dicer clear"].freeze

module Commands
  class Clear
    def initialize(bot:, channel:)
      @bot = bot
      @channel = channel
    end

    def perform
      channel.prune(100) { |message| message_eligible_to_delete(message) }
    rescue StandardError => e
      puts e
      puts "Can't delete commands from #{channel.name}"
    end

    private

    attr_reader :channel, :bot

    def message_eligible_to_delete(message)
      COMMANDS.find { |command| message.content.start_with? command } || message.author.current_bot?
    end
  end
end
