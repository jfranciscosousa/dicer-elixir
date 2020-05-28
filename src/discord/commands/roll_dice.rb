class Discord::Commands::RollDice
  def initialize(input:)
    @input = input
    @rand = Random.new
    @calculator = Dentaku::Calculator.new
  end

  def perform
    Timeout.timeout(Discord::Commands::DEFAULT_TIMEOUT) do
      dice_values = parse_dice_values
      evaluated_expression = calculator.evaluate(dice_values)

      return "#{dice_values} = #{evaluated_expression}" if evaluated_expression
    end
  rescue Timeout::Error
    warn "A instance of a !roll command expireds"
  end

  private

  attr_reader :input, :rand, :calculator

  def parse_dice_values
    input.slice!("!roll ")

    input.gsub(/[0-9]+d[0-9]+/) do |dice|
      roll_dice(dice)
    end
  end

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
