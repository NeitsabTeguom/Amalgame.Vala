using GLib;

class FileUtils {
    public static bool get_contents(string path, out string content) {
        try {
            content = FileUtils.read_file(path);
            return true;
        } catch (Error e) {
            stderr.printf("Erreur lecture fichier '%s' : %s\n", path, e.message);
            content = "";
            return false;
        }
    }

    public static string read_file(string path) {
        return FileUtils.read_file_contents(path);
    }

    public static string read_file_contents(string path) {
        var file = GLib.File.new_for_path(path);

        GLib.Bytes? contents_bytes;
        GLib.FileInfo? info;
        GLib.Error? error = null;

        bool success = file.load_contents(null, out contents_bytes, out info, out error);

        if (!success || contents_bytes == null) {
            throw new GLib.Error.FAILED("Impossible de lire " + path + (error != null ? ": " + error.message : ""));
        }

        return (string)contents_bytes.get_data();
    }
}

// Lexer, Parser, AST, etc. supposés déjà définis dans le projet.

int run_test(string base_name) {
    string dsl_path = base_name + ".dsl";
    string cpp_path = base_name + ".cpp";

    string dsl_code;
    string expected_cpp;

    if (!FileUtils.get_contents(dsl_path, out dsl_code)) return 1;
    if (!FileUtils.get_contents(cpp_path, out expected_cpp)) return 1;

    // Création du lexer et parser (adapté à ta structure)
    Lexer lexer = new Lexer(dsl_code);
    Parser parser = new Parser(lexer);
    var ast = parser.parse_program();

    string generated_cpp = ast.to_cpp().trim();

    if (generated_cpp == expected_cpp.trim()) {
        stdout.printf("✅ Test '%s' réussi.\n", base_name);
        return 0;
    } else {
        stderr.printf("❌ Test '%s' échoué.\n", base_name);
        stderr.printf("Code attendu:\n%s\n\nCode généré:\n%s\n", expected_cpp, generated_cpp);
        return 1;
    }
}

int main(string[] args) {
    // Liste des tests (ajoute les fichiers ici quand tu en as plus)
    string[] tests = {
        "tests/test_add_1",
        "tests/test_void_1",
        "tests/test_var_1"
    };

    int failures = 0;
    foreach (var test_base in tests) {
        failures += run_test(test_base);
    }

    if (failures == 0) {
        stdout.printf("\n🚀 Tous les tests sont passés avec succès !\n");
        return 0;
    } else {
        stderr.printf("\n⚠️ %d test(s) ont échoué.\n", failures);
        return 1;
    }
}
