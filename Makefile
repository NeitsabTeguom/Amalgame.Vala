# Makefile pour Amalgame

SRC = src/*.vala src/ast/*.vala
BIN = amalgame
TEST = test_runner

all: $(BIN) test

$(BIN): $(SRC)
	@echo "Compilation de $(BIN)..."
	valac --pkg gio-2.0 --pkg glib-2.0 $(SRC) -o $(BIN)

test: $(SRC) test_runner.vala
	@echo "Compilation de $(TEST)..."
	valac --pkg gio-2.0 --pkg glib-2.0 $(SRC) tests/$(TEST).vala -o $(TEST)
	@echo "Lancement des tests :"
	./tests/$(TEST)

clean:
	@echo "Nettoyage..."
	rm -f $(BIN) test_runner
