#include "gamelogic.h"
#include <QDebug>
#include <QDir>

//#define Q_OS_ANDROID

GameLogic::GameLogic(QObject *parent) : QObject(parent)
{
    difficulty = 2;
    timer1 = new QTimer(this);
    connect(timer1, SIGNAL(timeout()), this, SLOT(timer1000ms()));

    QString imagePath = "file:///"+QDir::currentPath()+"/";
#if defined(Q_OS_MAC)
    imagePath = "file://"+imagePath;
#endif
#if defined(Q_OS_ANDROID)
    imagePath = "assets:/";
#endif
    qDebug()<<"Assets path: "<<imagePath;
    assetsPath = imagePath;
}

GameLogic::~GameLogic()
{
    delete timer1;
}

int GameLogic::getDifficulty() const
{
    return difficulty;
}

int GameLogic::getTimeLeft() const
{
    return timeLeft;
}

void GameLogic::startGame()
{
    qDebug()<<"Game started!";
    nextLevel();
}

QString GameLogic::getAssetsPath()
{
    return assetsPath;
}

QString GameLogic::getAns(int x)
{
    switch(x){
    case 1:
        return ans1;
        break;
    case 2:
        return ans2;
        break;
    case 3:
        return ans3;
        break;
    case 4:
        return ans4;
        break;
    default:
        return "???";
    }
}

QString GameLogic::loadPicture()
{
    return assetsPath+picture;
}

void GameLogic::chosen(int x)
{
    if(x == (correct-1)){
        nextLevel();
        emit levelChanged();
    }
    else{
        finishGame();
    }
}

void GameLogic::nextLevel()
{
    qDebug()<<"New level";
    picture = "data/Level0/26/26-2-optimize_d.jpg";
    ans1 = "wrong1";
    ans2 = "wrong2";
    ans3 = "wrong3";
    ans4 = "correct";
    correct = 4;

    emit levelChanged();

    setTimeLeft(15);
    timer1->start(1000);
}

void GameLogic::finishGame()
{
    timer1->stop();
    emit gameOver();
    qDebug()<<"Game Over!";
}

void GameLogic::timer1000ms()
{
    setTimeLeft(timeLeft-1);
    if(timeLeft == 0){
        finishGame();
    }
}

void GameLogic::setDifficulty(int arg)
{
    if (difficulty == arg)
        return;

    difficulty = arg;
    emit difficultyChanged(arg);
}

void GameLogic::setTimeLeft(int arg)
{
    {
        if (timeLeft == arg)
            return;

        timeLeft = arg;
        emit timeLeftChanged(arg);
    }
}

