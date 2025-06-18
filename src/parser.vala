// parser.vala

public class Parser {
    private Lexer lexer;
    private Token current;

    public Parser(Lexer lexer) {
        this.lexer = lexer;
        this.current = lexer.next_token();
    }

    public FunctionNode parse_function() {
        string return_type = consume(TokenType.IDENTIFIER).lexeme;
        string name = consume(TokenType.IDENTIFIER).lexeme;
        consume_symbol("(");

        var parameters = new List<Parameter>();
        if (!check_symbol(")")) {
            do {
                string type = consume(TokenType.IDENTIFIER).lexeme;
                string pname = consume(TokenType.IDENTIFIER).lexeme;
                parameters = parameters.append(new Parameter(type, pname));
            } while (match_symbol(","));
        }

        consume_symbol(")");
        consume_symbol("{");

        var body = new BlockNode();
        while (!check_symbol("}")) {
            body.statements = body.statements.append(current.lexeme);
            advance();
        }

        consume_symbol("}");
        return new FunctionNode(return_type, name, parameters, body);
    }

    private Token consume(TokenType expected) {
        if (current.type == expected) {
            Token tmp = current;
            advance();
            return tmp;
        } else {
            stderr.printf("Expected %s but found %s\n", expected.to_string(), current.lexeme);
            return new Token(TokenType.UNKNOWN, current.lexeme, current.line);
        }
    }

    private void consume_symbol(string symbol) {
        if (current.lexeme == symbol) {
            advance();
        } else {
            stderr.printf("Expected symbol '%s' but found '%s'\n", symbol, current.lexeme);
        }
    }

    private bool match_symbol(string symbol) {
        if (current.lexeme == symbol) {
            advance();
            return true;
        }
        return false;
    }

    private bool check_symbol(string symbol) {
        return current.lexeme == symbol;
    }

    private void advance() {
        current = lexer.next_token();
    }
}
