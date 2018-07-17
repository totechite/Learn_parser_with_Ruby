class Token
  attr_reader :type, :text
  def initialize(type, text)
    @type = type
    @text = text
  end

  class << self
    attr_reader :type, :text
  end

  def to_s
    tname = ListLexer.tokenNames[@type]
    { type: tname, text: @text }
  end
end
