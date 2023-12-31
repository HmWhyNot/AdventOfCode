defmodule Days.Day1 do
  def partA do
    IO.puts("Day 1 - Part A:")

    inputFile = "input/day1.txt"
    fileStream = File.stream!(inputFile)
    # IO.inspect(fileStream)

    this = self()
    loopProc = spawn_link(fn -> sumLoop(0, this) end)
    spawn_link(fn -> readFileStream(fileStream, loopProc) end)
    maxLoop(0)
  end

  def partB do
    IO.puts("Day 1 - Part B:")

    inputFile = "input/day1.txt"
    fileStream = File.stream!(inputFile)
    # IO.inspect(fileStream)

    this = self()
    loopProc = spawn_link(fn -> sumLoop(0, this) end)
    spawn_link(fn -> readFileStream(fileStream, loopProc) end)
    topThree = topThreeLoop({0, 0, 0})
    Tuple.sum(topThree)
  end

  defp topThreeLoop(topThree) do
    receive do
      {:sum, value} ->
        case topThree do
          {x, y, _} when value > x ->
            topThreeLoop({value, x, y})
          {x, y, _} when value > y ->
            topThreeLoop({x, value, y})
          {x, y, z} when value > z ->
            topThreeLoop({x, y, value})
          {x, y, z} ->
            topThreeLoop({x, y, z})
        end
      :eof ->
        topThree
    end

  end

  defp maxLoop(max) do
    receive do
      {:sum, x} ->
        if x < max do
          maxLoop(max)
        else
          maxLoop(x)
        end
      :eof -> max
    end

  end

  defp sumLoop(sum, pid) do
    receive do
      {:line, line} ->
        sumLoop(sum + line, pid)
      :next ->
        send(pid, {:sum, sum})
        sumLoop(0, pid)
      :eof ->
        send(pid, :eof)
      after
        5000 ->
          send(pid, :eof)
    end
  end

  defp readFileStream(fileStream, pid) do
    Enum.each(fileStream, fn line ->
      line = String.trim(line)
      line = Integer.parse(line)
      case line do
        {x, _} ->
          send(pid, {:line, x})
        _ ->
          send(pid, :next)
      end
    end )
    send(pid, :eof)
    :ok
  end

end
