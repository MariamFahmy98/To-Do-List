#include "modelInterface.h"

#include <QtGui/qguiapplication.h>
#include <QtQml/qqmlapplicationengine.h>
#include <QtQml/qqmlcontext.h>
#include <QtQuick/qquickview.h>

int main(int argc, char*argv[])
{
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGLRhi);

    ModelInterface modelInterface;

    QGuiApplication app(argc, argv);
    QQuickView view;
    QQmlContext *context = view.engine()->rootContext();

    context->setContextProperty("modelInterface", &modelInterface);

    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setMinimumSize(QSize(500,800));
    view.show();

    return app.exec();
}
