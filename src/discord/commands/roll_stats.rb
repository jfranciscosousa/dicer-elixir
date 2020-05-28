# rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists
class Discord::Commands::RollStats
  def initialize(number_of_min: 0, number_of_max: 2, min_stat: 10, max_stat: 15, stat_baseline: 0, total_min: 70, total_max: 80)
    @number_of_min = number_of_min
    @number_of_max = number_of_max
    @min_stat = min_stat
    @max_stat = max_stat
    @stat_baseline = stat_baseline
    @total_min = total_min
    @total_max = total_max
    @stats = []
    @status = false
  end

  def perform
    return unless validate

    roll_stats until enough?

    stats
  end

  private

  attr_reader :number_of_min, :number_of_max, :max_stat, :min_stat, :stat_baseline, :total_min, :total_max
  attr_accessor :stats

  def validate
    return false if number_of_min + number_of_max > 6
    return false if number_of_min > 4 || number_of_max > 4
    return false if min_stat > max_stat
    return false if stat_baseline >= min_stat
    return false if stat_baseline > 8

    true
  end

  def roll_stats
    @stats = []

    @stats.push(roll_stat) until @stats.size == 6
  end

  def roll_stat
    values = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    top3 = values.sort { |x, y| y <=> x }.first(3)
    top3.inject(:+)
  end

  def enough?
    high_enough = 0
    low_enough = 0
    baseline_count = 0
    sum = 0

    stats.each do |stat|
      high_enough += 1 if stat > max_stat
      low_enough += 1 if stat < min_stat
      baseline_count += 1 if stat >= stat_baseline
      sum += stat
    end

    validate_stats(high_enough, low_enough, baseline_count, sum)
  end

  def validate_stats(high_enough, low_enough, baseline_count, sum)
    high_enough >= number_of_max && low_enough >= number_of_min && baseline_count == 6 && sum >= total_min && sum <= total_max
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists
