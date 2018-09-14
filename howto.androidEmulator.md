emulator -list-avds
1) android-sdk-macosx/tools/emulator -avd <avdname> -writable-system
2) ./adb root
3) ./adb remount
4) ./adb push <local>/hosts /etc/hosts
Android file host can be

/etc/hosts <--- This worked for me
/etc/system/hosts
/system/etc/hosts
Check

1) ./adb shell
2) cat /etc/hosts
3) ping customsite.com