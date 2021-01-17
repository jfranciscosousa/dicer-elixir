defmodule Dicer.RollStats do
  # Number of stats with less (or equal) than @min_stat value
  @number_of_min 0
  # Number of stats with more (or equal) @max_stat value
  @number_of_max 2
  # Min stat treshold
  @min_stat 10
  # Max stat treshold
  @max_stat 15
  # The lowest allowed stat
  @stat_baseline 0
  # The minimum sum of all stats
  @total_min 70
  # The maximum sum of all stats
  @total_max 80

  @spec call :: {:error, :max_iterations} | {:ok, [integer]}
  def call() do
    roll_stats(0)
  end

  # After 10,000 iterations just break the loop to save CPU
  defp roll_stats(10000) do
    {:error, :max_iterations}
  end

  defp roll_stats(tries) do
    stats = for(_i <- 1..6, do: roll_stat())

    if enough?(stats) do
      {:ok, stats}
    else
      roll_stats(tries + 1)
    end
  end

  defp roll_stat do
    [
      Enum.random(1..6),
      Enum.random(1..6),
      Enum.random(1..6),
      Enum.random(1..6)
    ]
    |> Enum.sort()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp enough?(stats) do
    Enum.reduce(
      stats,
      %{
        high_enough: 0,
        low_enough: 0,
        baseline_count: 0,
        sum: 0
      },
      fn stat, meta ->
        meta =
          if stat > @max_stat,
            do: increment_meta(meta, :high_enough),
            else: meta

        meta =
          if stat < @min_stat, do: increment_meta(meta, :low_enough), else: meta

        meta =
          if stat >= @stat_baseline,
            do: increment_meta(meta, :baseline_count),
            else: meta

        meta = increment_meta(meta, :sum, stat)

        meta
      end
    )
    |> validate_meta()
  end

  defp increment_meta(meta, key, value \\ 1) do
    Map.put(meta, key, meta[key] + value)
  end

  defp validate_meta(%{
         high_enough: high_enough,
         low_enough: low_enough,
         baseline_count: baseline_count,
         sum: sum
       }) do
    high_enough >= @number_of_max && low_enough >= @number_of_min &&
      baseline_count == 6 && sum >= @total_min && sum <= @total_max
  end
end
