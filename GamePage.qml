import QtQuick 2.0

Rectangle{
    id: inner
    anchors.fill: parent
    color: "lightgreen"

    signal levelChanged()
    onLevelChanged: {
        picture.source = game.loadPicture();
        answers.itemAt(0).variant = game.getAns(1);
        answers.itemAt(1).variant = game.getAns(2);
        answers.itemAt(2).variant = game.getAns(3);
        answers.itemAt(3).variant = game.getAns(4);
    }

    Item{
        anchors.fill: parent
        Row{
            anchors.top: parent.top
            id: topBar
            width: parent.width
            height: parent.height*0.2
            Rectangle{
                width: parent.width*0.4
                height: parent.height
                color: "blue"
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
            Rectangle{
                width: parent.width*0.4
                height: parent.height
                color: "lightpink"
            }
        }
        Image{
            anchors.top: topBar.bottom
            id: picture
            width: parent.width
            height:parent.height*0.4
            //source: game.getAssetsPath()+"data/Level0/62/62-3-optimize_d.jpg"
            //source: "assets:/data/Level0/62/62-3-optimize_d.jpg"
        }

        Column{
            anchors.top: picture.bottom
            width: parent.width
            height: parent.height*0.4
            spacing: height*0.02
            anchors.topMargin: height*0.02

            Repeater{
                id: answers
                model: 4
                Rectangle{
                    width: parent.width
                    height: parent.height*0.23
                    color: "red"
                    radius: height/3
                    property string variant: ""
                    Text{
                        anchors.centerIn: parent
                        text: parent.variant
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

