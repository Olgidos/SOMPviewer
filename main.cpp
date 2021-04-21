//Qt includes
#include <QApplication>
#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlApplicationEngine>


//Custom classes include
#include <controller/controller.h>
#include <libs/_qml.h>

//Test

FILE _iob[] = {*stdin, *stdout, *stderr};

extern "C" FILE * __cdecl __iob_func(void)
{
    return _iob;
}



int main(int argc, char *argv[])
{


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //IMPORTANT DONT TAKE QGUIApplication it crashes with Charts
    QApplication app(argc, argv);
    QFont fon("Verdana", 9);
    app.setFont(fon);

    QQmlApplicationEngine engine;

    //This global environmental variable needs to be set, else a Scene3D with visibility = false will block the program
    qputenv("QT3D_SCENE3D_STOP_RENDER_HIDDEN", "1");

    //create Controller w/ thread
    rootContext = engine.rootContext();
    Controller* controller = new Controller();

    //load QML into engine
    engine.load(QUrl(QStringLiteral("qrc:/resource/qml/MainWindow.qml")));

    controller->start();

    return app.exec();
}

