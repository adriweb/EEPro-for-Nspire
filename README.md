# FormulaPro.

### This is a [TI-Planet.org](http://tiplanet.org) project.
### Announce topic here : [FR](http://tiplanet.org/forum/viewtopic.php?t=8446) / [EN](http://tiplanet.org/forum/viewtopic.php?f=50&t=8455)
### Google Groups "tinspire" topic : [here](https://groups.google.com/forum/#!topic/tinspire/dYWb0poANyo).


### Licence : [LGPL3](http://www.gnu.org/licenses/lgpl.html)

##What is FormulaPro ? 
Here are the technical details : FormulaPro is a TI-Nspire (OS 3.x) document whose main content is a Lua script. Yep, all made in Nspire-Lua (http://www.inspired-lua.org). Indeed, it is the only way so far / right now to "properly" achieve what we do on FormulaPro (completely graphical UI, math calculations...).
FormulaPro is also free, of course, and open-source (https://github.com/adriweb/EEPro-for-Nspire/) (LGPL license) ! :-)


##Hmm ok, but what does it do ?  
Well, here you go : some of you may already know what's called "EEPro" or "MEPro" for the TI-89 and TI-92. It is an official program that TI puts in the 89 by default. If you don't know it, EEPro-89 is basically a program described by TI like this: "This application solves the problems of electrical engineering. It is composed of three modules: Analysis, Equations (700 equations grouped into 16 subjects) and Reference. " In short, a complete and very powerful application about Electrical Engineering. Well, FormulaPro is the 2nd part ("Equations") of our project to port the EEPro-89 suite to the Nspire. 
But we improved it, naturally. A lot. (And we already have plans and written code already ready for version 2.0 which will be even more awesome and more powerful.)

What FormulaPro right now is capable of, along with its website, is :
-to be able to run on any OS 3.x and any Nspire model and to be able to run on the computer software too with auto-resizing frames
-Mouse and keyboard input support, on both Software and Handheld
-to be able to let users generate their own pack of equations, smartly (variables and units are bound), within categories and sub-categories,
-to be able to solve intelligently solve the equations it's given, contrary to the 89 version, where the user had to select what equations had to be used : Indeed, here you just have to enter what you know already, and it will automatically try to solve for what it can. 
-it can very easily let you chose the unit/subunit you want to enter your data in. (for example Hz/kHz/MHz, °C/°F/°K etc.)
-it can show you the used formulas of the current sub-category in "PrettyPrint"


Great ! How do I use it ?
-Be sure to run Nspire OS >= 3.0. We recommand version 3.2.
-You can then either use the "demo" database (a part of the original EE-Pro one) available here (and also attached) : https://github.com/adriweb/EEPro-for-Nspire/blob/master/EEPro.tns?raw=true
 … or either starting your own database with our online FormulaPro Database maker which lets you easily create categories, subcategories, equations, units and subunits etc. It is available here: http://education.bwns.be/FormulaPro/
-If you were on the online generator, click the "Generate" button at the bottom of the page.
-Transfer the .tns to your calculator or in the computer software and open it.
-Select the category and the subcategory, and begin filling the input fields of the data you already know. Press enter or change focus, and it will start auto-solving. 
-Enjoy !


## Who .... ?
For now, The two main developers are Jim Bauwens and Adrien Bertrand ("Adriweb")
We also would like to thank Levak for his animation API and Nick Steen for the Resistor Reference part.
Many thanks too to Critor, Excale, NeoCrisis ... and TI of course :)

We welcome everybody, so if you want to help us, contact us by email (see down there)

## What .... ?
###Please READ (and comment if you want) this reference document : [Link](https://docs.google.com/document/d/1LBjZiKBB3k_bAIDWjTVRH9zTrX5DUQZ6BOXLhKveqJk/edit).

![The overall organization](http://i.imgur.com/UhHn7.png)
 
The only requirement to run the .tns files is to have an Nspire OS >= 3.0. You can find the latest updates [here](http://education.ti.com). Version 3.2 is preferred to enjoy the latest features, and 3.1 if you want to keep Ndless.

## What we have done, so far :
Well, "FormulaPro", the formulas/equation part (2nd part of EEPro).
This has been officially released (in beta) June 21st 2012 across multiple community websites :
http://www.omnimaga.org/index.php?topic=13849 ; https://groups.google.com/forum/?fromgroups#!topic/tinspire/dlqZrAKpulM ; http://tiplanet.org/forum/viewtopic.php?p=126193 ; http://www.inspired-lua.org/2012/06/formulapro-v1-is-here/

![Home Screen of FormulaPro](http://i.imgur.com/Uxy5N.jpg)
![Reference Screen of FormulaPro](http://i.imgur.com/lcrYU.jpg)
![Some solver screen](http://i.imgur.com/yUbY7.jpg)
![Formulas being displayed inside solver](http://i.imgur.com/4326g.jpg)

Please refer to the document linked in the previous paragraph.

At the same time, if you don't wish to be involved in a big thing, you can help with some of the Reference parts :-)

Then, the *big* part is the Analysis one, which we'll focus on later. (See the [EEPro Manual](http://tiplanet.org/modules/archives/eepro.pdf))

## Meet us on IRC :
- Here [via Mibbit](http://mibbit.com/chat/#eepronspire@efnet).
- Directly on your IRC client : EFNet Server, #eepronspire channel.


__Contact : info @ tiplanet . org__
