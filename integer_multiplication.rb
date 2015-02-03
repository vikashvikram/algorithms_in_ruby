class IntegerMultiplication
  POSITIVE, NEGATIVE = 1,-1

  def self.multiply(int1, int2)
    return 0 if int1 == 0 or int2 == 0
    sign = ((int1 > 0 and int2<0) or (int1<0 and int2 > 0)) ? NEGATIVE : POSITIVE
    int1, int2 = int1.abs, int2.abs
    do_math(int1, int2)*sign
  end
  
  def self.do_math(int1, int2)
    if int1/10 == 0
      return int1*int2
    else
      return 10*do_math(int1/10, int2) + (int1%10)*int2
    end
  end
end
