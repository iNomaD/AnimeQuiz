#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <QObject>

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int difficulty READ getDifficulty WRITE setDifficulty NOTIFY difficultyChanged)

public:
    explicit GameLogic(QObject *parent = 0);
    ~GameLogic();

    int getDifficulty() const;

    Q_INVOKABLE void startGame();
    Q_INVOKABLE QString getPath();
private:
    int difficulty;

signals:

    void difficultyChanged(int arg);

public slots:
    void setDifficulty(int arg);
};

#endif // GAMELOGIC_H
