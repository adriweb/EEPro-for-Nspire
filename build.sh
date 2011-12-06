#!/bin/sh

cat ./Global\ Libraries/screen.lua ./Global\ Libraries/widgets.lua ./main.lua>big.lua
luna big.lua EEPro.tns
