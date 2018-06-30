class Token
  attr_accessor :type, :text
  def initialize(type, text)
    @type = type
    @text = text
  end

  def to_s
    tname = ListLexer.tokenNames[@type]
    { type: tname, text: @text }
  end
end
