#include "gamelogic.h"
#include <QDebug>
#include <QDir>

GameLogic::GameLogic(QObject *parent) : QObject(parent)
{
    difficulty = 2;
}

GameLogic::~GameLogic()
{

}

int GameLogic::getDifficulty() const
{
    return difficulty;
}

void GameLogic::startGame()
{
    qDebug()<<"Game started!";
}

QString GameLogic::getPath()
{
    QString imagePath = QDir::currentPath()+"/data/";
    #if defined(Q_OS_MAC)
    imagePath = "file://"+imagePath;
    #endif
    qDebug()<<imagePath;
    return imagePath;
}

void GameLogic::setDifficulty(int arg)
{
    if (difficulty == arg)
        return;

    difficulty = arg;
    emit difficultyChanged(arg);
}

