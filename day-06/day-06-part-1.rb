lanternfish = File.open('input.txt', &:readline).split(',').map(&:to_i)

# Brute force! Track each fish individually.
# (This works fine for 80 iterations here, but does NOT scale to
# 256 iterations in Part 2, as the count of fish grows exponentially.)
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
