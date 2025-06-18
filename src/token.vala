// token.vala

public enum TokenType {
    IDENTIFIER,
    KEYWORD,
    NUMBER,
    STRING,
    SYMBOL,
    END_OF_FILE,
    UNKNOWN
}

public class Token {
    public TokenType type;
    public string lexeme;
    public int line;

    public Token(TokenType type, string lexeme, int line) {
        this.type = type;
        this.lexeme = lexeme;
        this.line = line;
    }

    public string to_string() {
        return "Token(" + type.to_string() + ", '" + lexeme + "', line " + line.to_string() + ")";
    }
}