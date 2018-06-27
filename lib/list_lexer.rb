class ListLexer < Lexer
  @tokenNames = %w[n/a <EOF> NAME COMMA L_BRACKET R_BRACEKT HEADING LIST]

  attr_reader :NAME, :COMMA, :L_BRACKET, :R_BRACKET
  def initialize(text)
    @NAME = 2
    @COMMA = 3
    @L_BRACKET = 4
    @R_BRACKET = 5
    super text
  end

  class << self
    attr_reader :tokenNames
  end

  def is_letter
    /[a-z]|[A-Z]/ === @char
  end

  def next_token
    eof = nil
    while @char != eof
      case @char
      when "\s" || "\t" || "\n" || "\r" || "\r\n"
        white_space
        continue
      when ','
        consume
        return Token.new @COMMA, ','
      when '['
        consume
        return Token.new @L_BRACKET, '['
      when ']'
        consume
        return Token.new @R_BRACKET, ']'
      else
        begin
          return name_token if is_letter
        rescue RuntimeError
          puts $ERROR_INFO
          puts $ERROR_POSITION
        end
      end
    end
    Token.new @EOF_TYPE, '<EOF>'
  end

  def name_token
    str = ''
    frag = true
    while frag
      str += @char
      consume
      frag = is_letter
    end
    Token.new @NAME, str
  end

  def white_space
    consume while @char == ("\s" || "\t" || "\n" || "\r" || "\r\n")
  end
end
