#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include "toDoModel.h"

int main(int argc, char*argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<ToDoModel>("ToDoModel", 1, 0, "ToDoModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QString(QML_DIR) + "/main.qml"));
    return app.exec();
}
