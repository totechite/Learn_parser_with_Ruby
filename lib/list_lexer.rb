class ListLexer < Lexer
  @tokenNames = %w[n/a <EOF> NAME COMMA L_BRACKET R_BRACEKT SHARP LIST LINE_FEED]
  @NAME = 2
  @COMMA = 3
  @L_BRACKET = 4
  @R_BRACKET = 5
  @SHARP = 6
  @LINE_FEED = 7

  def initialize(text)
    @tokenNames = %w[n/a <EOF> NAME COMMA L_BRACKET R_BRACEKT SHARP LIST LINE_FEED]
    @NAME = 2
    @COMMA = 3
    @L_BRACKET = 4
    @R_BRACKET = 5
    @SHARP = 6
    @LINE_FEED = 7
    super text
  end

  class << self
    attr_reader :tokenNames, :NAME, :COMMA, :L_BRACKET, :R_BRACKET, :SHARP, :LINE_FEED
  end

  def is_letter?
    (@char =~ /[a-z]|[A-Z]/) != nil 
  end

  def is_sharp?
    @char == "#"
  end

  def next_token
    eof = nil
    while @char != eof
      case @char
      when "\s" || "\t" || "\n" || "\r" || "\r\n"
        white_space
        next
      when ','
        consume
        return Token.new(@COMMA, ',')
      when '['
        consume
        return Token.new(@L_BRACKET, '[')
      when ']'
        consume
        return Token.new(@R_BRACKET, ']')
      when '#'
        return sharp_token if is_sharp?
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
      frag = is_letter?
      consume
    end
    Token.new @NAME, str
  end

  def sharp_token
    str = ''
    frag = true
    while frag
      str += @char
      consume
      frag = is_sharp?
    end
    Token.new @SHARP, str
  end


  def white_space
    consume while @char == ("\s" || "\t" || "\n" || "\r" || "\r\n")
  end
end
