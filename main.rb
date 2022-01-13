mode = (scale :C4, :minor, num_octaves: 2)
use_synth :piano
use_bpm 60

define :drift do |list, seed, quant|
  total = list.length
  raise = quant * 3
  sleeps = []
  (list.length - 1).times do
    val = quantise(raise * quant * Math.sin(Math::PI * seed/20) + (raise + 0.25), quant)
    rem = quantise((list.length - sleeps.sum)/2, quant)
    if total - val > 0
      sleeps.append(val)
      total -= val
      seed += 1
    else
      sleeps.append(rem)
      total -= rem
    end
  end
  sleeps.append(list.length - sleeps.sum)
  puts sleeps
  sleeps
end

live_loop :that do
  ls = [1, 3, 7, 5]
  notes = drift(ls, tick(:three), 3)
  ls.length.times do
    play mode[notes.tick(:four)]
    sleep 0.25
  end
end


live_loop :metro do
  sample :bd_sone
  8.times do
    sample :bd_tek
    sleep 1
  end
end
