This project is based on nesdoug's SNES_03 Super Nintendo dev example project. The only major changes are to the defines.asm file, in which I replaced most of his custom register/variable names with those found in the official Super Nintendo development documentation, and the image source itself, which is derived from textures from the System Shock 1 game, but manually arranged and pallette chosen by myself.

You can find his project here: https://github.com/nesdoug/SNES_03
SS1 textures found here: https://www.systemshock.org/index.php?topic=155.0

To create the .sfc file that runs on the emulator (higan/bsnes preferred for accuracy), you'll run the make file, just make it executable.
ca65 will create an output file based on the mainSS.asm, then the ld65 command will link it the lorom256k.cfg file, and produce the final output.
Written in 65c816 assembly, and lorom256k written in cc65 toolchain code.
