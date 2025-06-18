// lexer.vala

using GLib;

public class Lexer {
    private string source;
    private int index = 0;
    private int line = 1;

    public Lexer(string source) {
        this.source = source;
    }

    public Token next_token() {
        skip_whitespace();
        if (index >= source.length) return new Token(TokenType.END_OF_FILE, "", line);

        char current = source[index];

        if (isalpha(current) || current == '_') return identifier_or_keyword();
        if (isdigit(current)) return number();
        if (current == '"') return string_literal();

        index++;
        return new Token(TokenType.SYMBOL, current.to_string(), line);
    }

    private void skip_whitespace() {
        while (index < source.length && (source[index] == ' ' || source[index] == '\t' || source[index] == '\n')) {
            if (source[index] == '\n') line++;
            index++;
        }
    }

    private Token identifier_or_keyword() {
        int start = index;
        while (index < source.length && (isalnum(source[index]) || source[index] == '_')) index++;
        string lexeme = source.substring(start, index - start);
        return new Token(TokenType.IDENTIFIER, lexeme, line);
    }

    private Token number() {
        int start = index;
        while (index < source.length && isdigit(source[index])) index++;
        string lexeme = source.substring(start, index - start);
        return new Token(TokenType.NUMBER, lexeme, line);
    }

    private Token string_literal() {
        index++; // skip opening quote
        int start = index;
        while (index < source.length && source[index] != '"') index++;
        string lexeme = source.substring(start, index - start);
        index++; // skip closing quote
        return new Token(TokenType.STRING, lexeme, line);
    }

    private bool isalpha(char c) {
        return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
    }

    private bool isdigit(char c) {
        return (c >= '0' && c <= '9');
    }

    private bool isalnum(char c) {
        return isalpha(c) || isdigit(c);
    }
}