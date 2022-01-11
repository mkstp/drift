ls = [0, 5, 6, 1, 3, 5]
use_random_seed 6
#the max value in the choose parameter times
#the number of items in the list minus 1
#cannot be greater than the number of items in the list


define :drift do |seed|
  total = ls.length
  sleeps = []
  (ls.length - 1).times do
    val = quantise(Math.sin(seed) + 1.125, 0.25)
    if total - val > 0
      sleeps.append(val)
      total -= val
      seed += 1
      puts total
    else
      sleeps.append(quantise((ls.length - sleeps.sum)/2, 0.125))
      total -= quantise((ls.length - sleeps.sum)/2, 0.125)
      puts total
    end
  end
  sleeps.append(ls.length - sleeps.sum)
  sleeps
end

live_loop :this do
  rests = drift(tick(:one))
  atck = drift(tick(:one))
  rels = drift(tick(:one))
  ls.length.times do
    use_synth :piano
    play (scale :Eb4, :aeolian)[ls.tick(:two)], release: rels.look(:two)
    sleep rests.look(:two)
  end
end

live_loop :metro do
  sample :bd_sone
  13.times do
    sample :bd_tek
    sleep 1
  end
end

