CXX = g++
CXX_FLAGS = -std=c++17 -Wall -Wextra -Werror
SAN_FLAGS = -fsanitize=address -pedantic
COV_FLAGS = --coverage 
LDLIBS = -lgtest

TEST_DIR = ./tests
REPORT_DIR = ./report

SOURCES = ./*.cc ./model/*.cc ./view/*.cc ./tests/*.cc
HEADERS = ./model/*.h ./view/*.h
TESTS = $(wildcard $(TEST_DIR)/*.cc ./model/*.cc)

OS:=$(shell uname -s)
ifeq ($(OS), Darwin)
	OPEN = open
	RUN = open ./build/Maze.app/
	LEAKS =	leaks -atExit -- 
else
	OPEN = xdg-open
	RUN = ./build/Maze
	LEAKS = valgrind 
endif

rebuild: clean all

all: tests gcov_report install run

install: clean
	mkdir -p build
	cmake -S ./ -B ./build
	cd build && make

run:
	$(RUN)

uninstall: 
	rm -rf ./build/
	rm -rf ./*.txt

dvi:
	cd doxygen && doxygen Maze_config
	open doxygen/html/index.html

dist: install
	tar -cf Maze.tar build/*

tests: clean
	$(CXX) $(FLAGS) $(SAN_FLAGS) $(TESTS) $(LDLIBS) -o tests.out
	./tests.out

$(REPORT_DIR):
	mkdir -p $(REPORT_DIR)

gcov_report: $(REPORT_DIR)
	$(CXX) $(FLAGS) $(SAN_FLAGS) $(COV_FLAGS) $(TESTS) $(LDLIBS) -o report.out
	./report.out
	lcov -o $(REPORT_DIR)/maze.info -c -d . --no-external
	genhtml $(REPORT_DIR)/maze.info -o $(REPORT_DIR)
	$(OPEN) $(REPORT_DIR)/index.html
	rm -rf *.gcda *.gcno

clean:
	@rm -rf test *.o *.a *.css *.html *.gcda *.gcno *.info $(REPORT_DIR)
	@rm -rf report.out tests.out build* ./*txt.user Maze.tar
	@rm -rf doxygen/html doxygen/latex

style:
	cppcheck $(SOURCES) $(HEADERS) --language=c++
	clang-format -style=Google -i $(SOURCES) $(HEADERS)
	clang-format -style=Google -n $(SOURCES) $(HEADERS)

leaks: clean
	$(CXX) $(FLAGS) $(TESTS) $(LDLIBS) -o tests.out
	$(LEAKS)./tests.out