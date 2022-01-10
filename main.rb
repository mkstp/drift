ls = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
use_random_seed 6
#the max value in the choose parameter times
#the number of items in the list minus 1
#cannot be greater than the number of items in the list




define :drift do |seed|
  total = ls.length
  sleeps = []
  (ls.length - 1).times do
    val = quantise(Math.sin(seed) + 1, 0.25)
    if total - val > 0
      sleeps.append(val)
      total -= val
      seed += 1
      puts total
    else
      sleeps.append((ls.length - sleeps.sum)/2)
      total -= (ls.length - sleeps.sum)/2
      puts total
    end
  end
  sleeps.append(ls.length - sleeps.sum)
  sleeps
end

live_loop :this do
  that = drift(look)
  ls.length.times do
    play 60 + ls.tick
    sleep that.look
  end
end

live_loop :metro do
  sample :bd_sone
  13.times do
    sample :bd_tek
    sleep 1
  end
end

