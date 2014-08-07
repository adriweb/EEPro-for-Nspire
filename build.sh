#!/bin/sh

# Jim and Adriweb
# Building FormulaPro Nspire v1.41b....

echo "Building FormulaPro Nspire v1.41b..."
echo "Building the database"

cd 0\ -\ \ Database
./build.sh

#cd ..
#cd 1\ -\ \ Analysis\ Part
#./build.sh

echo "Building the FormulaPro core"
cd ..
cd 2\ -\ \ FormulaPro
./build.sh

echo "Building Reference"
cd ..
cd 3\ -\ \ Reference\ Part
./build.sh

echo "Building the libraries"
cd ..
cd Global\ Libraries
./build.sh

cd ..

echo "Creating the whole thing..."
#cat Database.big.lua lib.big.lua FormulaPro.big.lua Analysis.big.lua Reference.big.lua main.lua > EEPro.big.lua
cat Database.big.lua lib.big.lua FormulaPro.big.lua Reference.big.lua main.lua > EEPro.big.lua
luna EEPro.big.lua EEPro.tns
cp EEPro.tns FormulaPro.tns

echo "Done building"
echo "Cleaning up"

rm lib.big.lua
rm FormulaPro.big.lua
#rm Analysis.big.lua
rm Reference.big.lua
rm Database.big.lua
#rm EEPro.big.lua

echo "Done. Enjoy !"

