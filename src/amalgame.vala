// amalgame.vala

public static int main(string[] args) {
    if (args.length < 2) {
        print("Usage: amalgame <source.amal>\n");
        return 1;
    }

    string source_code = read_file_contents(args[1]);
    Lexer lexer = new Lexer(source_code);
    Parser parser = new Parser(lexer);

    var fn = parser.parse_function();
    fn.print(0);
    return 0;
}
