# Credits
ui_print ""
ui_print "******************************************"
ui_print "            LineageOS Dialer              "
ui_print "                                          "
ui_print "                By Poras                  "
ui_print "******************************************"
ui_print ""

# path
SYSTEM=`realpath $MIRROR/system`
PRODUCT=`realpath $MIRROR/product`
VENDOR=`realpath $MIRROR/vendor`
SYSTEM_EXT=`realpath $MIRROR/system_ext`

# function
conflict() {
for NAMES in $NAME; do
  DIR=/data/adb/modules_update/$NAMES
  if [ -f $DIR/uninstall.sh ]; then
    sh $DIR/uninstall.sh
  fi
  rm -rf $DIR
  DIR=/data/adb/modules/$NAMES
  rm -f $DIR/update
  touch $DIR/remove
  FILE=/data/adb/modules/$NAMES/uninstall.sh
  if [ -f $FILE ]; then
    sh $FILE
    rm -f $FILE
  fi
  rm -rf /metadata/magisk/$NAMES
  rm -rf /mnt/vendor/persist/magisk/$NAMES
  rm -rf /persist/magisk/$NAMES
  rm -rf /data/unencrypted/magisk/$NAMES
  rm -rf /cache/magisk/$NAMES
  rm -rf /cust/magisk/$NAMES
done
}

# function
cleanup() {
if [ -f $DIR/uninstall.sh ]; then
  sh $DIR/uninstall.sh
fi
DIR=/data/adb/modules_update/$MODID
if [ -f $DIR/uninstall.sh ]; then
  sh $DIR/uninstall.sh
fi
}

# function
hide_oat() {
for APPS in $APP; do
  REPLACE="$REPLACE
  `find $MODPATH/system -type d -name $APPS | sed "s|$MODPATH||"`/oat"
done
}
replace_dir() {
if [ -d $DIR ]; then
  REPLACE="$REPLACE $MODDIR"
fi
}
hide_app() {
DIR=$SYSTEM/app/$APPS
MODDIR=/system/app/$APPS
replace_dir
DIR=$SYSTEM/priv-app/$APPS
MODDIR=/system/priv-app/$APPS
replace_dir
DIR=$PRODUCT/app/$APPS
MODDIR=/system/product/app/$APPS
replace_dir
DIR=$PRODUCT/priv-app/$APPS
MODDIR=/system/product/priv-app/$APPS
replace_dir
DIR=$MY_PRODUCT/app/$APPS
MODDIR=/system/product/app/$APPS
replace_dir
DIR=$MY_PRODUCT/priv-app/$APPS
MODDIR=/system/product/priv-app/$APPS
replace_dir
DIR=$PRODUCT/preinstall/$APPS
MODDIR=/system/product/preinstall/$APPS
replace_dir
DIR=$SYSTEM_EXT/app/$APPS
MODDIR=/system/system_ext/app/$APPS
replace_dir
DIR=$SYSTEM_EXT/priv-app/$APPS
MODDIR=/system/system_ext/priv-app/$APPS
replace_dir
DIR=$VENDOR/app/$APPS
MODDIR=/system/vendor/app/$APPS
replace_dir
DIR=$VENDOR/euclid/product/app/$APPS
MODDIR=/system/vendor/euclid/product/app/$APPS
replace_dir
}

# hide
APP="`ls $MODPATH/system/app` `ls $MODPATH/system/priv-app` `ls $MODPATH/system/product/app` `ls $MODPATH/system/product/priv-app` `ls $MODPATH/system/system_ext/app` `ls $MODPATH/system/system_ext/priv-app`"
hide_oat
APP="GoogleDialer GoogleContacts PrebuiltBugle"
for APPS in $APP; do
  hide_app
done
