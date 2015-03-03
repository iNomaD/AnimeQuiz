import QtQuick 2.4


Rectangle {
    anchors.fill: parent
    color: "lightblue"
    width: parent.width
    height: parent.height

    Column{
        anchors.centerIn: parent
        spacing: 5

        TextEdit {
            id: textEdit1
            width: 111
            height: 20
            text: qsTr("Welcome guy")
            font.bold: true
            font.family: "Courier"
            font.pixelSize: 18
        }
        Rectangle {
            id: newgame
            width: 184
            height: 40
            color: "#f81919"
            border.color: "black"
            border.width: 5
            radius: 10

            Text {
                id: text1
                x: 42
                y: 8
                width: 90
                height: 24
                text: qsTr("New Game")
                font.pixelSize: 17
            }

            MouseArea{
                anchors.fill:parent
                onClicked: {
                    game.startGame();
                    pagelist.state = "game";    
                }
            }
        }

        Rectangle {
            id: options
            width: 184
            height: 40
            color: "#f81919"
            border.color: "black"
            border.width: 5
            radius: 10

            Text {
                id: text2
                x: 42
                y: 8
                width: 90
                height: 24
                text: qsTr("Options")
                font.pixelSize: 17
            }
            MouseArea{
                anchors.fill:parent
                onClicked: {

                }
            }
        }
        Text {
            text: "My property is: " + game.difficulty
        }

    }
}

