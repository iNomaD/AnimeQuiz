import QtQuick 2.4
import QtQuick.Controls 1.3
import LogicModule 1.0

ApplicationWindow {
    width: 300
    height: 600
    title: qsTr("Anime Quiz")
    visible: true

    GameLogic{
        id: game

        onShowRight: game_p.showRight();
        onShowWrong: game_p.showWrong();
        onLevelChanged: game_p.levelChanged();
        onHideSkip: game_p.hideSkip();
        onHideFiftyfifty: game_p.hideFiftyfifty();
        onGameStart: game_p.gameStart();
        onGameOver: {
            pagelist.state = "menu";
            menu_p.gameOver();
        }
    }

    Item{
        id: pagelist
        anchors.fill: parent

        MenuPage{
            id: menu_p
        }
        GamePage{
            id: game_p
        }

        states: [
            State {
                name: "menu"
                PropertyChanges { target: menu_p; visible:true; }
                PropertyChanges { target: game_p; visible:false; focus: false; }
            },
            State {
                name: "game"
                PropertyChanges { target: menu_p; visible:false; }
                PropertyChanges { target: game_p; visible:true; focus: true;}
            }
        ]
        state:"menu"
    }
}
