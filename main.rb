require './lib/index'

def main
  f = File.new "sample.md"
  lexer = ListLexer.new f
  token = lexer.next_token
  puts token.to_s

  while token.to_s[:type]!="<EOF>"
  token = lexer.next_token
  puts token.to_s
  end

end

def test
  f = File.new "./sample.md"
  lexer = ListLexer.new f

end

main()