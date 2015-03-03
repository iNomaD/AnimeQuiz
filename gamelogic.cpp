#include "gamelogic.h"
#include <QDebug>
#include <QDir>

//#define Q_OS_ANDROID

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

QString GameLogic::getAssetsPath()
{
    QString imagePath = "file:///"+QDir::currentPath()+"/";
    #if defined(Q_OS_MAC)
    imagePath = "file://"+imagePath;
    #endif
    #if defined(Q_OS_ANDROID)
    imagePath = "assets:/";
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

