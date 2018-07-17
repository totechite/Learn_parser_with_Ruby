class Parser
  def initialize(input)
    @input = input
    @lookahead = @input.next_token
  end

  def match(n)
    if @lookahead.type == n
      consume
    else
      raise RuntimeError
      puts 'expecting' + @input.tokenNames + '; found' + @lookahead
    end
  end

  def consume
    @lookahead = @input.next_token
  end
end
