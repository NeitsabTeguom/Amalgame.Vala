// utils.vala

public static string read_file_contents(string path) {
    try {
        string contents;
        FileUtils.get_contents (path, out contents);
        return contents;
    } catch (Error e) {
        stderr.printf("Erreur : %s\n", e.message);
        return "";
    }
}
