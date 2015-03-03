#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <gamelogic.h>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<GameLogic>("LogicModule", 1, 0, "GameLogic");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
