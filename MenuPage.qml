import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls.Private 1.0

Rectangle {
    anchors.fill: parent
    color: "lightblue"
    width: parent.width
    height: parent.height

    signal gameOver()
    onGameOver: {
        welcome.text = "Game Over\n Счёт: "+game.guessed
    }

    Image {
        id: background
        anchors.fill: parent
        source: "images/img/bg1.jpeg"
        //source: game.getAssetsPath()+"data/img/bg1.jpeg"
        fillMode: Image.PreserveAspectCrop
    }

    Column{
        width: parent.width*0.7
        height: parent.height*0.3
        anchors.centerIn: parent
        spacing: height/20

        Text {
            id: welcome
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height/3
            text: "Это что за аниме?"
            font.bold: true
            font.family: "Courier"
            font.pixelSize: 21
            wrapMode: Text.Wrap
        }
        ComboBox {
            id: box
            currentIndex: 1
            model: ListModel {
                id: cbItems
                ListElement { text: "Лёгкий"; color: "Yellow" }
                ListElement { text: "Средний"; color: "Green" }
                ListElement { text: "Отаку"; color: "Brown" }
            }
            width: parent.width
            height: parent.height*0.27
            style: ComboBoxStyle {
                background: Item{
                    Rectangle {
                        id: rectCategory
                        width: box.width
                        height: box.height
                        color: "#f81919"
                        border.color: "black"
                        border.width: 5
                        radius: height/3
                    }
                }

                label: Item {
                    anchors.fill: parent
                    Item{
                        id: lvltxt
                        width:parent.width*0.8
                        height:parent.height
                        anchors.left: parent.left
                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 5
                            font.bold: true
                            font.family: "Courier"
                            font.pixelSize: 18
                            wrapMode: Text.Wrap
                            text: control.currentText
                        }
                    }
                    Image{
                        anchors.left:lvltxt.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: height
                        height: parent.height*0.7
                        source: "images/img/triangle.png"
                    }
                }

                // drop-down customization here
                property Component __dropDownStyle: MenuStyle {
                    __maxPopupHeight: 600
                    __menuItemType: "comboboxitem"

                    frame: Rectangle {              // background
                        color: "#FA7A7A"
                        border.width: 2
                        radius: 7
                    }

                    itemDelegate.label:             // an item text
                        Text {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pointSize: 15
                        font.family: "Courier"
                        font.capitalization: Font.SmallCaps
                        color: styleData.selected ? "white" : "black"
                        text: styleData.text
                    }

                    itemDelegate.background: Rectangle {  // selection of an item
                        radius: 2
                        color: styleData.selected ? "#f81919" : "transparent"
                    }

                    __scrollerStyle: ScrollViewStyle { }
                }
            }
            onCurrentIndexChanged: game.difficulty = currentIndex+1
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
                text: "Новая игра"
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
                text: "Выход"
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

