class parser
    @input
    @lookahead
    @k
    @p=0
    def initialize(Lexer, input, k)
        @input = input
        @k = k
        @lookahead = Token.new
    end

    def consume
        @lookahead[@p]=@input.nextToken()
        @p = (P+1)%k
    end

end
