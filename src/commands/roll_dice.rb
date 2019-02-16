require "dentaku"

module Commands
  class RollDice
    def initialize(input:)
      @input = input
      @rand = Random.new
      @calculator = Dentaku::Calculator.new
    end

    def perform
      input.slice!("!roll ")

      dice_values = input.gsub(/[0-9]+d[0-9]+/) do |dice|
        roll_dice(dice)
      end

      "#{dice_values} = #{calculator.evaluate(dice_values)}"
    end

    private

    attr_reader :input, :rand, :calculator

    def roll_dice(dice)
      values = dice.split("d").map(&:to_i)
      number_of_dice = values[0]
      dice_size = values[1]
      dice_value = Array.new(number_of_dice) { 1 + @rand.rand(dice_size) }

      format_dice dice_value
    end

    def format_dice(dice_value)
      formatted_dice = dice_value.join(" + ")

      return "(#{formatted_dice})" if dice_value.size > 1

      formatted_dice
    end
  end
end