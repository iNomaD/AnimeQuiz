android-no-sdk {
    target.path = /data/user/qt
    export(target.path)
    INSTALLS += target
} else:android {
    x86 {
        target.path = /libs/x86
    } else: armeabi-v7a {
        target.path = /libs/armeabi-v7a
    } else {
        target.path = /libs/armeabi
    }
    export(target.path)
    INSTALLS += target

} else:unix {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}


installPrefix = /assets
for(deploymentfolder, DEPLOYMENTFOLDERS) {
item = item$${deploymentfolder}
itemfiles = $${item}.files
$$itemfiles = $$eval($${deploymentfolder}.source)
itempath = $${item}.path
$$itempath =
$${installPrefix}/qml/$${TARGET}/$$eval($${deploymentfolder}.target)
export($$itemfiles)
export($$itempath)
INSTALLS += $$item
}


export(INSTALLS)
