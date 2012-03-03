#!/usr/bin/python

import PythonMagick
import sys

print( '----------------------------------------------')
print( '          Image to Ti.Image converter'         )
print( '            (C) Jim Bauwens, 2011')
print( '----------------------------------------------')
print( '' )


if len(sys.argv)<3:
	print("Usage: " + sys.argv[0] + " <infile> <outfile>")
	sys.exit(2)

file	=	sys.argv[1]
outfile = sys.argv[2]
output = ""

def addZ(str,n):
	leng	=	len(str)
	for i in range(n-leng):
	 	str = "0" + str
	return str

def toHeader(n,w):
	binstring = bin(n)[2:]
	binstring = addZ(binstring,w*8)
	output = ""
	print binstring
	for i in range(w):
		output = "\\" + addZ(str(int(binstring[i*8:i*8+8],2)),3) + output
	return output


def convcolor(r,g,b):
	r = min(int(round(r/2048)),31)
	g = min(int(round(g/2048)),31)
	b = min(int(round(b/2048)),31)
	
	binstring = "1" + addZ(bin(r)[2:],5) + addZ(bin(g)[2:],5) + addZ(bin(b)[2:],5)
	number1 = int(binstring[8:],2)
	number2 = int(binstring[:8],2)
	output = ""
	if (number1>31 and number1<127 and number1 != 92 and number1 != 34):
		output = chr(number1)
	else:
		output = "\\" + addZ(str(number1),3)
		
	if (number2>31 and number2<127 and number2 != 92 and number2 != 34):
		output = output + chr(number2)
	else:
		output = output + "\\" + addZ(str(number2),3)	
	
	if (output=="\\255\\255"):
		output = "ww"
	return output


img	=	PythonMagick.Image(file)

height	=	img.size().height()#min(img.size().height(),150)
width		=	img.size().width()#min(img.size().width(),255)

output = toHeader(width,4) + toHeader(height,4) + toHeader(0,4) + toHeader(width*2,4) + "\\016\\000\\001\\000";

print ( "" )
sys.stdout.write('Converting')
	
for y in range(height):
	sys.stdout.write('.')
	sys.stdout.flush()
	for x in range(width):
		red	=	img.pixelColor(x,y).redQuantum()
		blue	=	img.pixelColor(x,y).blueQuantum()
		green	=	img.pixelColor(x,y).greenQuantum()
		output = output + convcolor(red,green,blue)
		
FILE = open(outfile,"w")
FILE.writelines(output)

print ( "" )
print ( "Done! (" + outfile + ")" )
print ( "" )
