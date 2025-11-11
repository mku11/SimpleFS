# use Linux or WSL or cygwin to run

# Java and Android
find ../../src -type f -name "*.java" | xargs javadoc -d ../../output/docs/java/html --ignore-source-errors

# .NET and Android .NET
doxygen Doxyfile.Net

# Python
doxygen DoxyfilePython
# alternative for python
# pdoc ../../src/python/simple_fs -o ../../output/docs/python/ --html --force