# Instead of tracking each fish individually, this solution tracks the count
# of fish at each "days left count" (which I call "cohorts"). This approach
# fixes the count of values that need to be acted upon at 9, instead of having
# that count grow exponentially as in the Part 1 solution.

def initial_lanternfish_cohorts
  lanternfish_individuals = File.open('input.txt', &:readline).split(',').map(&:to_i)
  lanternfish_cohorts = Array.new(9, 0)
  lanternfish_individuals.each do |fish|
    lanternfish_cohorts[fish] += 1
  end
  lanternfish_cohorts
end

def advance_day(lanternfish_cohorts)
  next_lanternfish_cohorts = Array.new(9, 0)
  next_lanternfish_cohorts[8] = lanternfish_cohorts[0]
  next_lanternfish_cohorts[6] = lanternfish_cohorts[0]
  (1..8).each do |i|
    next_lanternfish_cohorts[i - 1] += lanternfish_cohorts[i]
  end
  next_lanternfish_cohorts
end

lanternfish_cohorts = initial_lanternfish_cohorts

256.times do
  lanternfish_cohorts = advance_day(lanternfish_cohorts)
end

p lanternfish_cohorts.sum
