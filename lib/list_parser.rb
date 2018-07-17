class ListParser < Parser
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
    case @lookahead.type
    when ListLexer.NAME
      match(ListLexer.NAME)
    when ListLexer.L_BRACKET
      list
    end
  end
end
