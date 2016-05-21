def fibonacci(max)
  penultimate, last = 0, 1
  while penultimate <= max
    yield penultimate
    penultimate, last = last, penultimate + last
  end
end
fibonacci(1000) { |n| puts n }