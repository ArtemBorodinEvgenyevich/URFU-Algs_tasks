# frozen_string_literal: true


# Если нашли цикл, то сортируем массив, и берем все вершины влоть до той, на которой нашли цикл
# Выводим результат
def print_cycled(vertex)
  File.open('out.txt', 'w+') do |f|
    f.puts('N')

    @visited.sort!
    result = @visited[0, @visited.index(vertex) + 1]

    f.puts(result)
  end

  exit(0)
end

def prints_acycled
  File.open('out.txt', 'w+') do |f|
    f.puts('A')
  end
end

# Рекурсивно проходимся про вершинам и ее соседям
# Если уже прошлись по проверяемой вершине, то цикл найден
def check_for_cycle(vertex)
  print_cycled(vertex) if @visited.include?(vertex) # если повстречали уже пройденную вершину, то записываем цикл в файл

  @visited << vertex # если вершина не встречалась, то записываем ее в посещенные

  # Если у вершины есть соседи и соседи то рекурсивно повторяем алгоритм на них
  # Если значение соседа меньше текущей вершины, то пропускаем его.
  unless @nodes[vertex].nil?
    @nodes[vertex].each do |neighbour|
      next if neighbour < vertex

      check_for_cycle(neighbour)
    end
  end
end

# Заполняем словарь по списку смежностей, где ключ - номер вершины, значение - ее соседи
File.open('input.txt', 'r') do |f|
  @nodes = {}
  n = f.readline.to_i
  n.times do |index|
    neighbours = f.readline.split.map(&:to_i).reject{ |num| num == 0 }
    @nodes[(index + 1)] = neighbours
  end
end

@visited = [] # инициализируем массив посещенных вершин

check_for_cycle(1) # проверяем граф на цикличность
prints_acycled # выводим, что граф ацикличен
