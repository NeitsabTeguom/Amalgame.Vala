// ast.vala

public class Parameter {
    public string type;
    public string name;

    public Parameter(string type, string name) {
        this.type = type;
        this.name = name;
    }
}

public abstract class AstNode {
    public abstract void print(int indent);
}

public class BlockNode : AstNode {
    public List<string> statements;

    public BlockNode() {
        statements = new List<string>();
    }

    public override void print(int indent) {
        foreach (var stmt in statements) {
            print_indent(indent);
            stdout.printf("%s\n", stmt);
        }
    }

    private void print_indent(int indent) {
        for (int i = 0; i < indent; i++) stdout.printf("  ");
    }
}

public class FunctionNode : AstNode {
    public string return_type;
    public string name;
    public List<Parameter> parameters;
    public BlockNode body;

    public FunctionNode(string return_type, string name, unowned List<Parameter> parameters, BlockNode body) {
        this.return_type = return_type;
        this.name = name;
        this.parameters = parameters;
        this.body = body;
    }

    public override void print(int indent) {
        print_indent(indent);
        stdout.printf("Function %s %s(%s)\n", return_type, name, parameter_string());
        body.print(indent + 1);
    }

    private string parameter_string() {
        string[] parts = {};
        foreach (var p in parameters) parts += "%s %s".printf(p.type, p.name);
        return string.join(", ", parts);
    }

    private void print_indent(int indent) {
        for (int i = 0; i < indent; i++) stdout.printf("  ");
    }
}
