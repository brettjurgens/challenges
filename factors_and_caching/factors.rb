# in:   [10, 5, 2, 20]
# out:  { 10: [5, 2], 5: [], 2: [], 20: [10, 5, 2]}

def factor(list)
  list.sort!
  hash = {}

  list.each_with_index do |number, index|
    hash[number] = []
    divisors = list[0, index].clone
    until divisors.empty?
      divisor = divisors.pop
      if number % divisor == 0 && divisor != number
        hash[number] << divisor
        hash[number] += hash[divisor] unless hash[divisor].empty?
        divisors -= hash[divisor]
      end
    end
  end

  hash
end

puts factor [10, 5, 2, 20]
