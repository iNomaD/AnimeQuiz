import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import LogicModule 1.0

ApplicationWindow {
    width: 250
    height: 500
    title: qsTr("Anime Quiz")
    visible: true

    GameLogic{
        id: game
        difficulty: 3
    }

    /*menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
            MessageDialog {
                id: messageDialog
                title: qsTr("May I have your attention, please?")

                function show(caption) {
                    messageDialog.text = caption;
                    messageDialog.open();
                }
            }
        }
    }*/
    Item{
        id: pagelist
        anchors.fill: parent

        MenuPage{
            id: menu
        }
        GamePage{
            id: game_p
        }

        states: [
            State {
                name: "menu"
                PropertyChanges { target: game_p; visible:false; }
                PropertyChanges { target: menu; visible:true; }
            },
            State {
                name: "game"
                PropertyChanges { target: menu; visible:false; }
                PropertyChanges { target: game_p; visible:true; }
            }
        ]
        state:"menu"
    }
}
