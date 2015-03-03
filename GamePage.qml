import QtQuick 2.0

Rectangle{
    anchors.fill: parent
    color: "lightgreen"
    MouseArea{
        anchors.fill: parent
        onClicked: pagelist.state = "menu"
    }

    Column{
        anchors.fill: parent
        Row{
            width: parent.width
            height: parent.height*0.2
            Rectangle{
                width: parent.width/2
                height: parent.height
                color: "blue"
            }
            Rectangle{
                width: parent.width/2
                height: parent.height
                color: "lightblue"
            }
        }
        Image{
            width: parent.width
            height:parent.height*0.4
            source: "file:///"+game.getPath()+"Level0/87/87-5-optimize_d.jpg"

        }
        Column{
            width: parent.width
            height: parent.height*0.4
            Rectangle{
                anchors.fill: parent
                color: "red"
            }
        }
    }
    Text{
        anchors.centerIn: parent
        text: game.difficulty
    }
}

