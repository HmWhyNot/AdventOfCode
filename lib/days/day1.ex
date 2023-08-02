defmodule Days.Day1 do

  def partA do
    inputFile = "input/day1.txt"
    IO.puts("Day 1 - Bitwise Part a:")
    # {:ok, file} = File.open(inputFile, [:utf8])
    # IO.binread(file, :line)

    # File.read(inputFile)
    stream = File.stream!(inputFile, [], :line)
    # IO.puts(stream)
    for line <- stream do
      # IO.puts(line)
      IO.inspect(line)
    end
    # IO.inspect(stream)
    IO.puts("done")

  end
end
