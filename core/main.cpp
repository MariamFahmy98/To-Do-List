#include "toDoModel.h"

#include <QtGui/qguiapplication.h>
#include <QtQml/qqmlapplicationengine.h>
#include <QtQml/qqmlcontext.h>
#include <QtQuick/qquickview.h>

int main(int argc, char*argv[])
{
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGLRhi);

    QGuiApplication app(argc, argv);

    qmlRegisterType<ToDoModel>("ToDoModel", 1, 0, "ToDoModel");

    QQuickView view;
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setMinimumSize(QSize(500,800));
    view.show();

    return app.exec();
}
