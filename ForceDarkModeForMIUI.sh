umask 022

mount -o rw,remount /

configFile=/system/etc/ForceDarkAppSettings.json
configBackup=$configFile".bak"

if [ -e $configFile -a ! -e $configBackup ]; then
	mv $configFile  $configBackup
fi

echo "[" > $configFile
/system/bin/cmd package list packages -3 | cut -f 2 -d ":" | while read -r pkg; do echo '{"defaultEnable":false,"overrideEnableValue":0,"packageName":"'$pkg'","showInSettings":true},';done >> $configFile
echo "{}]" >> $configFile

chmod 644 $configFile
