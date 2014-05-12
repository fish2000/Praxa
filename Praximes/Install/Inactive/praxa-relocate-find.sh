#/usr/bin/env bash


find /usr/local/Praxa \
    -type f \
        \( -name "*.py"
       -or -name "*.html" \
       -or -name "*.css" \
       -or -name "*.conf" \
       -or -name "*.ini" \
       -or -name "*.xml" \
       -or -name "*.java" \
       -or -name "*.rb" \
       -or -name "*.c" \
       -or -name "*.h" \
       -or -name "*.cpp" \
       -or -name "*.hpp" \
       -or -name "*.i" \
       -or -name "*.ipp" \
           
           
           -exec sed -i 's/<string1>/<string2>/' {} +