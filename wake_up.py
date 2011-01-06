#!/usr/bin/python

from subprocess import Popen as p, PIPE
from time import sleep
from sys import argv

#with open('/sys/class/rtc/rtc0/wakealarm', 'w') as f:
#    f.write('0')

#with open('/sys/class/rtc/rtc0/wakealarm', 'w') as f:
#    f.write('1287324000')

#sleep(1)
atargs = argv
atargs[0]='at'

at = p(atargs, stdin=PIPE, stdout=PIPE)
try:
    time.strptime(p.stdout.readline(), "%a %b %d %H:%M:%S %Y")
except:
    print "at doesn't like the time format"

# various sleep commands
# see http://www.uluga.ubuntuforums.org/showthread.php?t=813387&page=5
# bad Ubuntu! Provide consistent interfaces for important components like power!
# lucid+
#dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend
# fairly portable
#/etc/acpi/sleep.sh sleep
# some weird cases
# echo "mem"> /sys/power/state

sleep 10

