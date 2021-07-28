#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QQmlContext>
#include "modelInterface.h"

int main(int argc, char*argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    QQmlContext *context = view.engine()->rootContext();

    ModelInterface modelInterface;
    context->setContextProperty("modelInterface", &modelInterface);

    view.setSource(QUrl(QString(QML_DIR) + "/main.qml"));
    view.show();
    return app.exec();
}
