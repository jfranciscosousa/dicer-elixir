defmodule Dicer.Roll do
  @spec call(String.t()) :: {:error, map} | {:ok, String.t(), number}
  def call(input) do
    with input <- String.trim(input),
         expression <-
           Regex.replace(~r/([0-9]+)d([0-9]+)/, input, &replace_fn/3),
         {:ok, total} <- Abacus.eval(expression) do
      {:ok, expression, total}
    else
      {:error, error} -> {:error, error}
    end
  end

  defp replace_fn(_, number_of_dice, dice) do
    handle_dice(String.to_integer(number_of_dice), String.to_integer(dice))
  end

  defp handle_dice(1, dice) do
    handle_one_dice(dice)
  end

  defp handle_dice(number_of_dice, dice) do
    cond do
      number_of_dice > 500 ->
        raise "Stop right there. That's too many dice"

      true ->
        for(_i <- 1..number_of_dice, do: handle_one_dice(dice))
        |> Enum.join(" + ")
    end
  end

  defp handle_one_dice(dice) do
    cond do
      dice > 1000 -> raise "Haha no. There are no dice this large."
      true -> :rand.uniform(dice) |> to_string
    end
  end
end
