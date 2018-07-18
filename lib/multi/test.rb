require "./lib/lexer.rb"
require_relative "LookaheadLexer.rb"
require_relative "parser.rb"
require_relative "LookaheadParser.rb"

def main
    f = File.new 'sample.md'
    lexer = LookaheadLexer.new(f)
    parser = LookaheadParser.new(lexer, 2)
    parser.list()
end

main()