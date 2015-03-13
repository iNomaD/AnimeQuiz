import QtQuick 2.4


Rectangle {
    anchors.fill: parent
    color: "lightblue"
    width: parent.width
    height: parent.height

    signal gameOver()
    onGameOver: {
       welcome.text = "Game Over\n Score: "+game.guessed
    }

    Image {
        id: background
        anchors.fill: parent
        source: game.getAssetsPath()+"data/img/bg1.jpeg"
        fillMode: Image.PreserveAspectCrop
    }

    Column{
        width: parent.width*0.7
        height: parent.height*0.3
        anchors.centerIn: parent
        spacing: 5

        Text {
            id: welcome
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height/3
            text: "Welcome to AnimeQuiz"
            font.bold: true
            font.family: "Courier"
            font.pixelSize: 21
            wrapMode: Text.Wrap
        }
        Rectangle {
            id: newgame
            width: parent.width
            height: parent.height*0.27
            color: "#f81919"
            border.color: "black"
            border.width: 5
            radius: height/3

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: "NEW GAME"
                font.bold: true
                font.family: "Courier"
                font.pixelSize: 18
                wrapMode: Text.Wrap
            }

            MouseArea{
                anchors.fill:parent
                onEntered: parent.border.color = "gold"
                onExited: parent.border.color = "black"
                onClicked: {
                    game.startGame();
                    pagelist.state = "game";    
                }
            }
        }

        Rectangle {
            id: exit
            width: parent.width
            height: parent.height*0.27
            color: "#f81919"
            border.color: "black"
            border.width: 5
            radius: height/3

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: "EXIT"
                font.bold: true
                font.family: "Courier"
                font.pixelSize: 18
                wrapMode: Text.Wrap
            }
            MouseArea{
                anchors.fill:parent
                onEntered: parent.border.color = "gold"
                onExited: parent.border.color = "black"
                onClicked: Qt.quit();
            }
        }

    }
}

