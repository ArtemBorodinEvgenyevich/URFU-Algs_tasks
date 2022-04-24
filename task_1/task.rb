# frozen_string_literal: true

File.open('input.txt', 'r') do |f|
  n = f.readline.to_i
  @colours = [-1] * n # цвета (-1 - неопределенб 0 - черный, 1 - белый)
  @graph = [] # граф смежности

  # задаем граф
  (0..n-1).each {
    neighbours = []
    row = f.readline.split.map { |char|  char.to_i }
    row.each_with_index { |value, index|
      neighbours << index + 1 if value == 1
    }
    @graph << neighbours unless neighbours.size == 0
  }
end

@queue = [1] # очередь обхода
@colours[0] = 0 # задаем цвет первой вершине графа

# обходим граф в порядке очереди
until @queue.size == 0
  v = @queue.shift
  @graph[v - 1].each do |neighbour|
    if @colours[neighbour - 1] == -1 # если сосед не закрашен - красим
      @queue << neighbour
      @colours[neighbour - 1] = (@colours[v - 1] + 1) % 2
    elsif @colours[neighbour - 1] == @colours[v - 1] # если сосед был посещен и имеет не наш цвет - граф не двудольный
      File.open("out.txt", "w+") {|f| f.write("N") }
      exit 0
    end
  end
end

# Выводим ответ
File.open('out.txt', 'w+') do |f|
  f.puts('Y')
  @colours.each_with_index { |colour, index|
    f.puts("#{index + 1}") if colour == 0
  }
  f.puts('0')
  @colours.each_with_index { |colour, index|
    f.puts("#{index + 1}") if colour == 1
  }
  f.puts('0')
end





