#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QWindow>
#include <QDir>
#include <QFile>
#include <QString>
#include <QSettings>
#include <unistd.h>
#include <QDBusInterface>

#include "qquickimage.h"
#include "xlibutil.h"
#include "context.h"
#include "backgroundconnect.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QFile file(path + "settings.conf");

    if(!dir.exists(path))
    {
        dir.mkpath(path);
    }

    if(!file.exists())
    {
        if (file.open(QIODevice::ReadWrite))
        {
            QSettings settings(path + "settings.conf", QSettings::NativeFormat);
            settings.setValue("background", "file:///usr/share/backgrounds/default.jpg");
            settings.setValue("path", "/usr/share/backgrounds");
            settings.setValue("terminal", "konsole");
        }

        file.close();
    }

    Context *context = new Context();
    QQuickImage image;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Context", context);
    engine.addImageProvider("pixmap", &image);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    context->engine = &engine;
    QObject *obj = engine.rootObjects().first();
    QWindow *window = qobject_cast<QWindow *>(obj);

    BackgroundConnect bg;
    bg.main = window;
    QDBusConnection connection = QDBusConnection::sessionBus();
    connection.registerObject("/", &bg, QDBusConnection::ExportAllSlots);
    connection.connect("emmi.interface.wallpaper", "/", "emmi.interface.wallpaper", "BgConnect", &bg, SLOT(BgConnect()));
    connection.registerService("emmi.interface.wallpaper");

    //context->window = window;
    Xlibutil util;
    util.openboxChange(window->winId(), ALL_DESKTOPS);
    util.xchange(window->winId(), "_NET_WM_WINDOW_TYPE_DESKTOP");

    return app.exec();
}
