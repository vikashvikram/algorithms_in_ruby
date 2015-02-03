class IntegerMultiplication
  POSITIVE, NEGATIVE = 1,-1

  def self.multiply(int1, int2)
    return 0 if int1 == 0 or int2 == 0
    sign = ((int1 > 0 and int2<0) or (int1<0 and int2 > 0)) ? NEGATIVE : POSITIVE
    int1, int2 = int1.abs, int2.abs
    puts "Integer multiplication of #{int1} and #{int2} using karatsuba algorithm : #{karatsuba(int1, int2)*sign}"
    puts "Integer multiplication of #{int1} and #{int2} using simple algorithm : #{do_math(int1, int2)*sign}"
    do_math(int1, int2)*sign
  end

  def self.karatsuba(int1, int2)
    if int1 < 10 or int2 < 10
      return int1*int2 if int1 < 10 or int2 < 10
    else
      len = int1.to_s.length
      num11, num12 = int1/10**(len/2), int1%10**(len/2)
      num21, num22 = int2/10**(len/2), int2%10**(len/2)
      karat1 = karatsuba(num11, num21)
      karat2 = karatsuba(num12, num22)
      karat3 = karatsuba(num11+num12, num21+num22) - (karat1+karat2)
      return (10**len)*karat1+(10**(len/2))*karat3+karat2
    end
  end
  
  def self.do_math(int1, int2)
    if int1/10 == 0
      return int1*int2
    else
      return 10*do_math(int1/10, int2) + (int1%10)*int2
    end
  end
end
