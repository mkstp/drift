ls = [0, 5, 6, 1, 3, 5]
mode = (scale :Eb4, :aeolian)
use_synth :piano


define :drift do |seed|
  total = ls.length
  sleeps = []
  (ls.length - 1).times do
    val = quantise(Math.sin( Math::PI * seed / 2) + 1.125, 0.125)
    rem = quantise((ls.length - sleeps.sum)/2, 0.125)
    if total - val > 0
      sleeps.append(val)
      total -= val
      seed += 1
    else
      sleeps.append(rem)
      total -= rem
    end
  end
  sleeps.append(ls.length - sleeps.sum)
  sleeps
end

live_loop :this do
  rests = drift(tick(:one))
  ls.length.times do
    play mode[ls.tick(:two)]
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

