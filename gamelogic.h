#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <QObject>
#include <QTimer>
#include <QStringList>
#include <QVector>
#include <QTime>

struct AnimeTitle
{
    QString name;
    QString top;
    QString year;
    QStringList pic;
};

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int difficulty READ getDifficulty WRITE setDifficulty NOTIFY difficultyChanged)
    Q_PROPERTY(int timeLeft READ getTimeLeft WRITE setTimeLeft NOTIFY timeLeftChanged)
    Q_PROPERTY(int guessed READ getGuessed WRITE setGuessed NOTIFY guessedChanged)
    Q_PROPERTY(QString allTime READ getAllTime WRITE setAllTime NOTIFY allTimeChanged)

public:
    explicit GameLogic(QObject *parent = 0);
    ~GameLogic();

    Q_INVOKABLE void startGame();
    Q_INVOKABLE QString getAssetsPath();
    Q_INVOKABLE QString getAns(int x);
    Q_INVOKABLE QString loadPicture();
    Q_INVOKABLE void chosen(int x);
    Q_INVOKABLE int getCorrect();
    Q_INVOKABLE int getIncorrect();
    Q_INVOKABLE int getFifty(int x);
    Q_INVOKABLE void fiftyfifty();
    Q_INVOKABLE void skip();
    Q_INVOKABLE void abortGame();

    int getDifficulty() const;
    int getTimeLeft() const;
    int getGuessed() const;
    QString getAllTime() const;

private:
    int difficulty;
    int timeLeft;
    int guessed;
    QString allTime;

    int correct;
    int incorrect;
    int fifty[2];
    QVector<AnimeTitle> data;
    QString assetsPath;
    QString picture;
    QString ans[4];
    QTime allTimeD;
    QTimer *timer1;
    bool pause;
    bool abort;

    void nextLevel();
    void finishGame();
    void loadData();
    void delay(int millisecondsToWait);
    AnimeTitle pickAnime();

signals:

    void difficultyChanged(int arg);
    void levelChanged();
    void gameStart();
    void gameOver();
    void timeLeftChanged(int arg);
    void guessedChanged(int arg);
    void allTimeChanged(QString arg);
    void showRight();
    void showWrong();
    void hideFiftyfifty();
    void hideSkip();

public slots:
    void setDifficulty(int arg);
    void setTimeLeft(int arg);
    void timer1000ms();
    void setGuessed(int arg);
    void setAllTime(QString arg);
};

#endif // GAMELOGIC_H
