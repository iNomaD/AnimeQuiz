#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <QObject>
#include <QTimer>

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int difficulty READ getDifficulty WRITE setDifficulty NOTIFY difficultyChanged)
    Q_PROPERTY(int timeLeft READ getTimeLeft WRITE setTimeLeft NOTIFY timeLeftChanged)

public:
    explicit GameLogic(QObject *parent = 0);
    ~GameLogic();

    int getDifficulty() const;
    int getTimeLeft() const;

    Q_INVOKABLE void startGame();
    Q_INVOKABLE QString getAssetsPath();
    Q_INVOKABLE QString getAns(int x);
    Q_INVOKABLE QString loadPicture();
    Q_INVOKABLE void chosen(int x);

private:
    int difficulty;
    int timeLeft;

    QTimer *timer1;
    QString assetsPath;
    QString picture;
    QString ans1;
    QString ans2;
    QString ans3;
    QString ans4;
    int correct;

    void nextLevel();
    void finishGame();

signals:

    void difficultyChanged(int arg);
    void levelChanged();
    void gameOver();
    void timeLeftChanged(int arg);

public slots:
    void setDifficulty(int arg);
    void setTimeLeft(int arg);
    void timer1000ms();
};

#endif // GAMELOGIC_H
