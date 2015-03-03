TEMPLATE = app

folder_01.source = data
folder_01.target = data
DEPLOYMENTFOLDERS = folder_01

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
