#include "gamelogic.h"
#include <QDebug>
#include <QDir>
#include "QTime"
#include <QCoreApplication>
#include <QApplication>

//#define Q_OS_ANDROID

GameLogic::GameLogic(QObject *parent) : QObject(parent)
{
    setDifficulty(1);
    incorrect = -1;
    pause = false;
    abort = false;
    timer1 = new QTimer(this);
    connect(timer1, SIGNAL(timeout()), this, SLOT(timer1000ms()));

    curPath = QApplication::applicationDirPath();
    QString imagePath = "file:///"+curPath+"/";
#if defined(Q_OS_MAC)
    imagePath = "file://"+imagePath;
#endif
#if defined(Q_OS_ANDROID)
    imagePath = "assets:/";
#endif
    qDebug()<<"Assets path: "<<imagePath;
    assetsPath = imagePath;

    loadData();

    //для рандома
    QTime midnight(0,0,0);
    qsrand(midnight.secsTo(QTime::currentTime()));
}
GameLogic::~GameLogic()
{
    delete timer1;
}

void GameLogic::delay( int millisecondsToWait )
{
    QTime dieTime = QTime::currentTime().addMSecs( millisecondsToWait );
    while( QTime::currentTime() < dieTime )
    {
        QCoreApplication::processEvents( QEventLoop::AllEvents, 100 );
    }
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
    qDebug()<<"Game started! Titles: "<<data.size()<<"Difficulty: "<<difficulty;
    allTimeD.setHMS(0,0,0);
    setAllTime(allTimeD.toString("hh:mm:ss"));
    setGuessed(0);
    emit gameStart();
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
        return ans[0];
        break;
    case 2:
        return ans[1];
        break;
    case 3:
        return ans[2];
        break;
    case 4:
        return ans[3];
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
    if(x == fifty[0] || x == fifty[1] || pause){
        return;
    }
    pause = true;
    if(x == (correct)){
        setGuessed(getGuessed()+1);
        emit showRight();
        delay(300);
        nextLevel();
    }
    else{
        incorrect = x;
        finishGame();
    }
}

int GameLogic::getGuessed() const
{
    return guessed;
}

QString GameLogic::getAllTime() const
{
    return allTime;
}

AnimeTitle GameLogic::pickAnime()
{
    int maxTop=500, minYear=1900;
    if(difficulty <1 || difficulty>3){
        difficulty = 3;
    }
    switch(difficulty){
    case 1: //229 штук
        maxTop = 300;
        minYear = 2000;
        break;
    case 2: // +151 штук
        maxTop = 500;
        minYear = 2000;
        break;
    case 3: // +70 штук
        maxTop = 500;
        minYear = 1900;
        break;
    }
    AnimeTitle at;
    while(true){
        at = data.at(qrand() % data.size());
        if((at.top).toInt() <= maxTop && (at.year).toInt() >= minYear){
            break;
        }
        //qDebug()<<at.name<<at.top<<"NE OK";
    }
    return at;
}

void GameLogic::nextLevel()
{
    qDebug()<<"New level";
    /*int count = 0;
    foreach(AnimeTitle at, data){
        if((at.year).toInt()>=2000 && (at.top).toInt()>300){
            count++;
            //qDebug()<<at.name<<" "<<at.top<<" "<<at.year;
        }
    }
    qDebug()<<count;*/

    fifty[0] = fifty[1] = -1; //не юзали 50 на 50
    ans[0] = ans[1] = ans[2] = ans[3] = "NO DATA";
    if(data.size() < 4){
        correct = -1;
    }
    else{
        //выбираем анимешку
        AnimeTitle at = pickAnime();
        qDebug()<<at.name<<at.top;

        //перемешиваем ответы
        correct = qrand()%4;
        ans[correct] = at.name + " (" + at.year + ")";
        picture = at.pic.at(qrand() % at.pic.size());

        for(int i=0; i<4; ++i){
            if(i != correct){
                bool again = true;
                while(again){
                    again = false;
                    AnimeTitle at2 = pickAnime();
                    for(int j=0; j<4; ++j){
                        if(ans[j] == at2.name + " (" + at2.year + ")"){
                            again = true;
                        }
                    }
                    ans[i] = at2.name + " (" + at2.year + ")";
                }
            }
        }
    }

    emit levelChanged();
    setTimeLeft(15);
    timer1->start(1000);
    pause = false;
}

void GameLogic::finishGame()
{
    timer1->stop();
    if(!abort){
        if(incorrect != -1) emit showWrong();
        else emit showRight();
        delay(1000);
        incorrect = -1;
    }
    emit gameOver();
    qDebug()<<"Game Over!";
}

void GameLogic::loadData()
{
    QDir dirs;
    dirs.setPath(curPath+"/data/Level0");
#if defined(Q_OS_ANDROID)
    dirs.setPath("assets:/data/Level0");
#endif

    qDebug()<<"GAME LOADING DATA FROM "+dirs.currentPath();
    foreach(QString directory, dirs.entryList()){
        //qDebug()<<directory;
        if(directory != "." && directory != ".."){
            AnimeTitle newTitle;

            QDir title = dirs;
            title.cd(directory);

            QFile info(title.path()+"/info.txt");
            info.open(QIODevice::ReadOnly);
            QString all = info.readAll();

            QStringList line = all.split("\r\n");
            #ifdef Q_OS_LINUX
                    line = all.split("\n");
            #endif
            newTitle.name = line[0];
            newTitle.year = line[1];
            newTitle.top = line[2];
            info.close();

            QStringList list = title.entryList(QStringList(QString("*.jpg")));
            //не добавляем если меньше 3 картинок!
            if(list.size() >= 3){
                foreach(QString file, list){
                    newTitle.pic.append("data/Level0/"+directory+"/"+file);
                }
                data.append(newTitle);
            }
        }
    }
}

void GameLogic::timer1000ms()
{
    allTimeD = allTimeD.addSecs(1);
    setAllTime(allTimeD.toString("hh:mm:ss"));
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
void GameLogic::setGuessed(int arg)
{
    if (guessed == arg)
        return;

    guessed = arg;
    emit guessedChanged(arg);
}
void GameLogic::setAllTime(QString arg)
{
    if (allTime == arg)
        return;

    allTime = arg;
    emit allTimeChanged(arg);
}
int GameLogic::getCorrect()
{
    return correct;
}
int GameLogic::getIncorrect()
{
    return incorrect;
}
int GameLogic::getFifty(int x)
{
    if(x==0) return fifty[0];
    else if(x==1) return fifty[1];
    else return -1;
}

void GameLogic::fiftyfifty()
{
    fifty[0] = qrand() % 4;
    while(fifty[0] == correct) fifty[0] = qrand() % 4;
    fifty[1] = qrand() % 4;
    while(fifty[1] == correct || fifty[1] == fifty[0]) fifty[1] = qrand() % 4;
    emit hideFiftyfifty();
}

void GameLogic::skip()
{
    emit hideSkip();
    nextLevel();
}

void GameLogic::abortGame()
{
    abort = true;
    finishGame();
}
