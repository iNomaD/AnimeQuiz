TEMPLATE = app

android {
    deployment.files=data
    deployment.path=/assets
    INSTALLS += deployment
}

QT += qml quick widgets

SOURCES += main.cpp \
    gamelogic.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat

HEADERS += \
    gamelogic.h

win32:RC_FILE = miku.rc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
