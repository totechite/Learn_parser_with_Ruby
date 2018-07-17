require "spec_helper"
require "lexer.rb"
require "list_lexer.rb"

f = File.new 'sample.md'
lexer = ListLexer.new f

describe ListLexer.NAME do
  it "is 2" do
    expect(ListLexer.NAME).to eq 2
  end
end