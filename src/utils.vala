// utils.vala

public static string load_file(string path) {
    try {
        File file = File.new_for_path(path);
        char[] contents;
        file.load_contents(null, out contents, null);
        return (string) contents;
    } catch (Error e) {
        stderr.printf("Erreur : %s\n", e.message);
        return "";
    }
}
