ls = [0, 5, 6, 1, 3, 5, 9, 11]
mode = (scale :C3, :dorian, num_octaves: 3)
use_synth :piano
use_bpm 180

define :drift do |seed|
  total = ls.length
  sleeps = []
  (ls.length - 1).times do
    val = quantise(0.5 * Math.sin( Math::PI * seed / 2) + 1.25, 0.5)
    rem = quantise((ls.length - sleeps.sum)/2, 0.5)
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

live_loop :that do
  rests = drift(1 + tick(:three))
  ls.length.times do
    play mode[ls.tick(:four) + 2]
    sleep rests.look(:four)
  end
end

live_loop :tho do
  rests = drift(2 + tick(:five))
  ls.length.times do
    play mode[ls.tick(:six) + 5]
    sleep rests.look(:six)
  end
end

live_loop :metro do
  sample :bd_sone
  8.times do
    sample :bd_tek
    sleep 1
  end
end

