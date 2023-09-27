mount -o rw,remount /data
[ -z $MODPATH ] && MODPATH=${0%/*}
[ -z $MODID ] && MODID=`basename "$MODPATH"`

# cleaning
APPS="`ls $MODPATH/system/app` `ls $MODPATH/system/priv-app` `ls $MODPATH/system/product/app` `ls $MODPATH/system/product/priv-app` `ls $MODPATH/system/system_ext/app` `ls $MODPATH/system/system_ext/priv-app`"
for APP in $APPS; do
  rm -f `find /data/system/package_cache -type f -name *$APP*`
  rm -f `find /data/dalvik-cache /data/resource-cache -type f -name *$APP*.apk`
done
rm -rf /metadata/magisk/"$MODID"
rm -rf /mnt/vendor/persist/magisk/"$MODID"
rm -rf /persist/magisk/"$MODID"
rm -rf /data/unencrypted/magisk/"$MODID"
rm -rf /cache/magisk/"$MODID"
