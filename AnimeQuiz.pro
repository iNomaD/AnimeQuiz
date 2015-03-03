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

DISTFILES +=

HEADERS += \
    gamelogic.h
