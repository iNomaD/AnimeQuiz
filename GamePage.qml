import QtQuick 2.0

Item{
    id: inner
    anchors.fill: parent
    //color: "lightgreen"

    signal levelChanged()
    onLevelChanged: {
        picture.source = game.loadPicture();
        answers.itemAt(0).variant = game.getAns(1);
        answers.itemAt(1).variant = game.getAns(2);
        answers.itemAt(2).variant = game.getAns(3);
        answers.itemAt(3).variant = game.getAns(4);
    }

    Image {
        id: background
        anchors.fill: parent
        source: game.getAssetsPath()+"data/img/bg2.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Item{
        anchors.fill: parent
        Row{
            anchors.top: parent.top
            id: topBar
            width: parent.width
            height: parent.height*0.2

            Item{
                width: parent.width*0.4
                height: parent.height
                //color: "blue"
                Column{
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.1
                    anchors.top: parent.top
                    anchors.topMargin: parent.height*0.1
                    spacing: parent.height*0.4

                    Text{
                        text: "Угадано: "+game.guessed
                    }
                    Text{
                        text: "Время: "+game.allTime
                    }
                }
            }
            Item{
                width: parent.width*0.2
                height: parent.height
                Rectangle{
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.width
                    radius: parent.width/2
                    color: "gold"
                    Text{
                        anchors.centerIn: parent
                        text: game.timeLeft
                    }
                }
            }
            Item{
                width: parent.width*0.4
                height: parent.height
                //color: "lightpink"
            }
        }
        Image{
            anchors.top: topBar.bottom
            id: picture
            width: parent.width
            height:parent.height*0.4
        }

        Column{
            anchors.top: picture.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.98
            height: parent.height*0.4
            spacing: height*0.03
            anchors.topMargin: height*0.03

            Repeater{
                id: answers
                model: 4
                Rectangle{
                    width: parent.width
                    height: parent.height*0.22
                    color: "red"
                    radius: height/3
                    property string variant: ""

                    Text{
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: parent.variant
                        maximumLineCount: 2
                        wrapMode: Text.Wrap
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: game.chosen(index);
                    }
                }
            }
        }
    }
}

