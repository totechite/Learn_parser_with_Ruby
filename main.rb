require './lib/index'

def main
  f = File.new "sample.md"
  lexer = ListLexer.new f
  frag = true
  while frag
    token = lexer.next_token
    puts token.to_s
    frag = token.to_s[:type]!="<EOF>"
  end

end

main()