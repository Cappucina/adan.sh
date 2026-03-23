#!/bin/bash

git clone https://github.com/Cappucina/ADAN.git
cd ADAN

chmod +x ./dependencies.sh
./dependencies.sh

make

echo "We need sudo to move to your binaries."

sudo mv ./build/adan /bin/adan
