class Sed
  def initialize(string, delimiter='/')
    @string = string
    @delimiter = delimiter
  end

  def substitute(replacer, replacee)
    %x(echo #{@string} | sed s/#{replacer}/#{replacee}/)
  end

end

s = Sed.new("my name is khan")
puts s.substitute("khan", "harry")