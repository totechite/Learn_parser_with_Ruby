require './lib/index'

def main
  f = File.new 'sample.md'
  lexer = ListLexer.new f
  parser = ListParser.new(lexer)
  parser.list
  # frag = true
  # while frag
  #   token = lexer.next_token
  #   puts token.to_s
  #   frag = token.to_s[:type] != '<EOF>'
  # end
end

main
