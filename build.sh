#!/bin/sh
# Jim and Adriweb
# Building EEProNspire....

echo "Building EEProNspire..."


cd 1\ -\ \ Analysis\ Part
./build.sh

cd ..
cd 2\ -\ \ FormulaPro
./build.sh

cd ..
cd 3\ -\ \ Reference\ Part
./build.sh

cd ..
cd Global\ Libraries
./build.sh

cd ..

cat lib.big.lua FormulaPro.big.lua Analysis.big.lua Reference.big.lua main.lua > EEPro.big.lua
luna EEPro.big.lua EEPro.tns

echo "Done building"
echo "Cleaning up"

rm lib.big.lua
rm FormulaPro.big.lua
rm Analysis.big.lua
rm Reference.big.lua
rm EEPro.big.lua
