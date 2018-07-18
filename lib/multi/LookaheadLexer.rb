class LookaheadLexer < Lexer
  @tokenNames = %w[n/a <EOF> NAME COMMA L_BRACKET R_BRACEKT EQUALS HEADING LIST ]
  @NAME = 2
  @COMMA = 3
  @L_BRACKET = 4
  @R_BRACKET = 5
  @EQUALS = 6

  def initialize(text)
    @tokenNames = %w[n/a <EOF> NAME COMMA L_BRACKET R_BRACEKT EQUALS HEADING LIST]
    @NAME = 2
    @COMMA = 3
    @L_BRACKET = 4
    @R_BRACKET = 5
    @EQUALS = 6
    super text
  end

  class << self
    attr_reader :tokenNames, :NAME, :COMMA, :L_BRACKET, :R_BRACKET, :EQUALS
  end

  def is_letter?
    if nil != (@char =~ /[a-z]|[A-Z]/)
      true
    else
      false
    end
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
        return Token.new(@COMMA, ',')
      when '['
        consume
        return Token.new(@L_BRACKET, '[')
      when ']'
        consume
        return Token.new(@R_BRACKET, ']')
      when '='
        consume
        return Token.new(@EQUALS, '=')
      else
        begin
          return name_token if is_letter?
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
      frag = is_letter?
    end
    Token.new @NAME, str
  end

  def white_space
    consume while @char == ("\s" || "\t" || "\n" || "\r" || "\r\n")
  end
end
