class ListLexer < Lexer

  @tokenNames = %w(n/a <EOF> NAME COMMA L_BRACKET R_BRACEKT HEADING LIST)

  attr_reader :NAME, :COMMA, :L_BRACKET, :R_BRACKET
  def initialize text
    @NAME = 2
    @COMMA = 3
    @L_BRACKET = 4
    @R_BRACKET = 5
    super text
  end

  def self.tokenNames
    @tokenNames
  end

  def is_letter
    /[a-z]|[A-Z]/ === @char
  end

  def next_token
    eof = nil.freeze
    while @char != eof
      case @char
        when "\s" || "\t" || "\n" || "\r" || "\r\n"
          self.white_space
          self.continue
        when ","
          self.consume
          return Token.new @COMMA, ","
        when "["
          self.consume
          return Token.new @L_BRACKET, "["
        when "]"
          self.consume
          return Token.new @R_BRACKET, "]"
        else
          begin
            if self.is_letter
              return self.name_token
            end
          rescue RuntimeError
            puts $!
            puts $@
          end
      end
    end
    return Token.new @EOF_TYPE, "<EOF>"
  end

  def name_token
    str = ""
    frag = true
    while frag
      str += @char
      self.consume
      frag = self.is_letter
    end
    return Token.new @NAME, str
  end

  # def heading_token
  #   str = ""
  #   while @char=="#"
  #     str = @char
  #     self.consume
  #   end
  #   return Token.new @HEADING, str
  # end


  def white_space
    while @char == ("\s" || "\t" || "\n" || "\r" || "\r\n")
      self.consume
    end
  end

end