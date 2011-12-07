#!/bin/sh

echo "Building EEPro"

cd FormulaPro
./build.sh

cd ..
cd Analysis\ Part
./build.sh

cd ..
cd Reference\ Part
./build.sh

cd ..
cd Global\ Libraries
./build.sh

cd ..


cat lib.big.lua FormulaPro.big.lua Analysis.big.lua Reference.big.lua main.lua>EEPro.big.lua
luna EEPro.big.lua EEPro.tns

echo "Done building"
echo "Cleaning up"

rm lib.big.lua
rm FormulaPro.big.lua
rm Analysis.big.lua
rm Reference.big.lua
rm EEPro.big.lua
