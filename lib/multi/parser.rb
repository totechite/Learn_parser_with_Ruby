class Parser
    @input
    @lookahead
    @k
    @p=0
    def initialize(input)
        @input = input
        @k = k
        @lookahead = Token.new
    end

    def consume
        @lookahead[@p]=@input.nextToken()
        @p = (@p+1) % @k
    end

    def LT(i)
        return lookahead[(@p+i) % @k]
    end

    def LA(i)
        return LT(i)[:type]
    end

    def match(x)
        if LA(1) == x
            consume
        else
            raise RuntimeError
        end
    end

end
