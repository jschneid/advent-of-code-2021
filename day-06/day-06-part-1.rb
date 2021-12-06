lanternfish = File.open('input.txt', &:readline).split(',').map(&:to_i)
80.times do
  spawned_fish = []
  lanternfish.each_index do |i|
    if lanternfish[i].zero?
      lanternfish[i] = 6
      spawned_fish << 8
    else
      lanternfish[i] -= 1
    end
  end
  lanternfish += spawned_fish
end
p lanternfish.count
