#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QQmlContext>
#include "modelInterface.h"

int main(int argc, char*argv[])
{
    ModelInterface modelInterface;
    QGuiApplication app(argc, argv);
    QQuickView view;
    QQmlContext *context = view.engine()->rootContext();

    context->setContextProperty("modelInterface", &modelInterface);

    view.setSource(QUrl("qrc:/main.qml"));
    view.setMinimumSize(QSize(500,800));
    view.show();
    return app.exec();
}
