# lexmark_linux_drivers
Linux driver for Lexmark X4650
-Latest driver extracted from lexmark-08z-series-driver-1.0-1.i386.rpm.sh.tar.gz
-Tested on Arch linux 64bit
-Includes PPDs for other printers too

Instructions
-------------
-Copy /usr folder at your local /usr folder :P
-Run "sudo ./08z-series-driver.link /usr/local/lexmark"
-Run "sudo ln -s /usr/lib/cups/backend/lxk08zusb /usr/lib/cups/backend/lxkusb"
-Connect your printer and install the PPD for your model (It's in 08zero/etc)

For 64bit you have to install lib32-libcups

If you get permission errors run this "sudo chown -R root /usr/lexinkjet/08zero/bin"
