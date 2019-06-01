#ifndef BACKGROUNDCONNECT_H
#define BACKGROUNDCONNECT_H

#include <QObject>
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusAbstractAdaptor>
#include <QWindow>
#include <QDebug>


class BackgroundConnect : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "emmi.interface.wallpaper")

public:
    QWindow *main;

public slots:
    void BgConnect(QString bg);
    //Q_SCRIPTABLE void BgConnect(QString bg);

};

#endif // BACKGROUNDCONNECT_H
