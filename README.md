# SASMac
---

[SASM](http://dman95.github.io/SASM/) is crossplatform IDE for NASM, MASM, GAS and FASM assembly languages.

However, it is not fully compatible with MacOS.<br>
I tried many different ways, and actually managed it to work as a native app, using [this tutorial](https://sites.google.com/a/brianrhall.net/www/rss/installingsasmonamac) by Brian R. Hall. However, this method works only with 64-bit programs, since Apple has now deprecated 32-bit compilation on newer releases of MacOS.

The [SASMac Launcher](SASMac.Launcher) is a simple script that will handle all the installation process of SASM using Docker and a X11 server.

## How to use

Put `SASMac Launcher` in the Application folder. Open a terminal window and run `chmod +x /Applications/SASMac\ Launcher`.<br>
If you like you can inspect the file and give it an icon.


## Thanks to

- ~Leon from Mac Support@TUM
- Dmitriy Manushin
- Brian R. Hall
- Many many StackOverflow users C:
- Sveinbjorn Thordarson


## Disclaimer
I haven't written a line of SASM, just part of this tool to get it running on Mac. All the credit for that goes to [Dmitriy Manushin](https://github.com/Dman95/SASM).
