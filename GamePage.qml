import QtQuick 2.4

Item{
    id: inner
    anchors.fill: parent

    Keys.onReleased: {
        if (event.key == Qt.Key_Back) {
            event.accepted = true;
            game.abortGame();
        }
    }

    signal gameStart()
    onGameStart: {
        skip_b.visible = true;
        fifty_b.visible = true;
    }
    signal showRight()
    onShowRight: {
        answers.itemAt(game.getCorrect()).state = "right"
    }
    signal showWrong()
    onShowWrong: {
        answers.itemAt(game.getCorrect()).state = "right"
        answers.itemAt(game.getIncorrect()).state = "wrong"
    }
    signal hideSkip()
    onHideSkip: {
        skip_b.visible = false;
    }
    signal hideFiftyfifty()
    onHideFiftyfifty: {
        fifty_b.visible = false;
        answers.itemAt(game.getFifty(0)).opacity = 0.0;
        answers.itemAt(game.getFifty(1)).opacity = 0.0;
    }
    signal levelChanged()
    onLevelChanged: {
        picture.source = game.loadPicture();
        for(var i=0; i<4; ++i){
            answers.itemAt(i).state = "normal";
            answers.itemAt(i).opacity = 1.0;
            answers.itemAt(i).variant = game.getAns(i+1);
        }
    }

    Image {
        id: background
        anchors.fill: parent
        source: "images/img/bg2.jpg"
        //source: game.getAssetsPath()+"data/img/bg2.jpg"
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
                Column{
                    width: parent.width
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.05
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width*0.3
                    anchors.top: parent.top
                    anchors.topMargin: parent.height*0.1
                    spacing: parent.height*0.2

                    Item{
                        width: parent.width
                        height: parent.height*0.3
                        Text{
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: "Угадано: "+game.guessed
                            wrapMode: Text.Wrap
                        }
                    }

                    Rectangle{
                        id: skip_b
                        width: parent.width
                        height: parent.height*0.3
                        color: "red";
                        radius: height/3
                        gradient: gr_help
                        border.width: 2
                        border.color: "darkblue"
                        Text{
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: "SKIP"
                            wrapMode: Text.Wrap
                            font.family: "Courier"
                            color: "brown"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onEntered: parent.border.color = "gold"
                            onExited: parent.border.color = "darkblue"
                            onClicked: game.skip();
                        }
                    }
                }
            }
            Item{
                width: parent.width*0.2
                height: parent.height
                Rectangle{
                    anchors.centerIn: parent
                    width: parent.height/2
                    height: parent.height/2
                    radius: width/2
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
                Column{
                    width: parent.width
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width*0.3
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width*0.05
                    anchors.top: parent.top
                    anchors.topMargin: parent.height*0.1
                    spacing: parent.height*0.2

                    Item{
                        width: parent.width
                        height: parent.height*0.3
                        Text{
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: "Время: "+game.allTime
                            wrapMode: Text.Wrap
                        }
                    }

                    Rectangle{
                        id: fifty_b
                        width: parent.width
                        height: parent.height*0.3
                        color: "red";
                        radius: height/3
                        gradient: gr_help
                        border.width: 2
                        border.color: "darkblue"
                        Text{
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: "50/50"
                            wrapMode: Text.Wrap
                            font.family: "Courier"
                            color: "brown"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onEntered: parent.border.color = "gold"
                            onExited: parent.border.color = "darkblue"
                            onClicked: game.fiftyfifty();
                        }
                    }

                    Gradient {
                        id: gr_help
                        GradientStop { position: 0.0; color: "lightsteelblue" }
                        GradientStop { position: 1.0; color: "gold" }
                    }
                }
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
                    id: button
                    width: parent.width
                    height: parent.height*0.22
                    radius: height/3
                    gradient: gr_normal
                    border.width: 2
                    border.color: "darkblue"
                    property string variant: ""

                    Text{
                        id: txt
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: parent.variant
                        maximumLineCount: 2
                        wrapMode: Text.Wrap
                    }
                    MouseArea{
                        anchors.fill: parent
                        onEntered: parent.border.color = "gold"
                        onExited: parent.border.color = "darkblue"
                        onClicked: game.chosen(index);
                    }
                    Gradient {
                        id: gr_normal
                        GradientStop { position: 0.0; color: "lightsteelblue" }
                        GradientStop { position: 1.0; color: "lightblue" }
                    }
                    Gradient {
                        id: gr_right
                        GradientStop { position: 0.0; color: "lightgreen" }
                        GradientStop { position: 1.0; color: "green" }
                    }
                    Gradient {
                        id: gr_wrong
                        GradientStop { position: 0.0; color: "pink" }
                        GradientStop { position: 1.0; color: "red" }
                    }
                    PropertyAnimation {
                        id: blink
                        running: false
                        target: button
                        property: "opacity"
                        from: 1
                        to: 0.8
                        duration: 200
                        loops: Animation.Infinite
                    }
                    states: [
                        State {
                            name: "normal"
                            PropertyChanges {
                                target: button;
                                gradient: gr_normal
                                opacity: 1.0
                            }
                        },
                        State {
                            name: "right"
                            PropertyChanges {
                                target: button;
                                gradient: gr_right
                            }
                            PropertyChanges {
                                target: blink;
                                running: true
                            }
                        },
                        State {
                            name: "wrong"
                            PropertyChanges {
                                target: button;
                                gradient: gr_wrong
                            }
                        }
                    ]
                    state:"normal"
                }
            }
        }
    }
}

