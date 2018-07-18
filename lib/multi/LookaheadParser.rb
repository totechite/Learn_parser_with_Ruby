class LookaheadParser < Parser
  def initialize(input)
    super(input)
   end

  def list
    match(ListLexer.L_BRACKET)
    elements
    match(ListLexer.R_BRACKET)
  end

  def elements
    element
    while @lookahead.type == ListLexer.COMMA
      match(ListLexer.COMMA)
      element
    end
  end

  def element
        if LA(1)==LookaheadLexer.NAME && LA(2)==LookaheadLexer.EQUALS
            match(LookaheadLexer.NAME)
            match(LookaheadLexer.EQUALS)
            match(LookaheadLexer.NAME)
        elsif LA(1)==LookaheadLexer.NAME
            match(LookaheadLexer.NAME)
        elsif LA(1)==LookaheadLexer.L_BRACKET
            list()
        else
            raise RuntimeError
        end
    end
end
