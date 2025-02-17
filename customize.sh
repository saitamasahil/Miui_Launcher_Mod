REPLACE="
/system/priv-app/MILauncher
/system/priv-app/MiLauncher
/system/priv-app/MILauncherGlobal
/system/priv-app/MiLauncherGlobal
/system/priv-app/MiuiHome
/system/priv-app/MIUIHome
/system/priv-app/MiuiLauncherGlobal
/system/priv-app/MIUILauncherGlobal
/system/product/priv-app/MILauncher
/system/product/priv-app/MiLauncher
/system/product/priv-app/MILauncherGlobal
/system/product/priv-app/MiLauncherGlobal
/system/product/priv-app/MiuiHome
/system/product/priv-app/MIUIHome
/system/product/priv-app/MiuiLauncherGlobal
/system/product/priv-app/MIUILauncherGlobal
"

SKIPUNZIP=1
SKIPMOUNT=false

install_files() {
    . $MODPATH/addon/install.sh

    ui_print " "
    ui_print " Warning: Miui 14 CN is not supported, read module post to know about installation."
    ui_print " "
    ui_print " "
    ui_print "Let's start"
    ui_print "Choose your Miui Version:"
    ui_print "  Vol+ = Miui 13 or lower"
    ui_print "  Vol- = Miui 14 Android 13 Xiaomi.eu based"
    ui_print " "

    if chooseport; then
        ui_print "- Miui 13 or lower selected"
        cp -rf $MODPATH/files/launcher/MiuiHome.apk $MODPATH/system/priv-app/aMiuiHome
    else
        {
            ui_print "- Miui 14 Eu selected"
            cp -rf $MODPATH/files/launcher/MiuiHome.apk $MODPATH/system/product/priv-app/aMiuiHome
        }

    fi
    ui_print " "
    ui_print " Is your device POCO?"
    ui_print "  Vol+ = Yes"
    ui_print "  Vol- = No"
    ui_print " "

    if chooseport; then
        ui_print "- Deleting POCO Launcher and adding MiuiHome support."
        cp -rf $MODPATH/files/poco/Framework_resoverlay.apk $MODPATH/system/product/overlay
    else
        {
            ui_print "- Skipping..."
        }

    fi

}

cleanup() {
    rm -rf $MODPATH/addon 2>/dev/null
    rm -rf $MODPATH/files 2>/dev/null
    rm -f $MODPATH/install.sh 2>/dev/null
    ui_print "- Deleting package cache files"
    rm -rf /data/resource-cache/*
    rm -rf /data/system/package_cache/*
    rm -rf /cache/*
    rm -rf /data/dalvik-cache/*
    ui_print "- Launcher updates will be uninstalled..."
    pm uninstall-system-updates com.miui.home
    ui_print "- Deleting old module (if it is installed)"
    touch /data/adb/modules/miui_launcher_mod/remove
}

run_install() {
    ui_print " "
    unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2
    ui_print " "
    ui_print "- Installing files"
    install_files
    sleep 1
    ui_print " "
    ui_print "- Cleaning up"
    ui_print " "
    cleanup
    sleep 1
    ui_print " "
    ui_print "- Removing any Miui Launcher folder to avoid issues"
}

run_install
