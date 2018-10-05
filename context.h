#ifndef CONTEXT_H
#define CONTEXT_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QUrl>
#include <QDebug>
#include <QStringList>
#include <QFileInfoList>
#include <QFileInfo>
#include <QScreen>
#include <QPoint>
#include <QCursor>
#include <QApplication>
#include <QDBusMessage>
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QWindow>


#include "xlibutil.h"


class Context : public QObject
{

    Q_OBJECT

public:
    Q_INVOKABLE void copy(QString from,QString to);
    Q_INVOKABLE QStringList backgrouds(QString path);
    Q_INVOKABLE void backgroundChange(QString bg);
    Q_INVOKABLE void allDesktop();
    Q_INVOKABLE int mouseX();
    Q_INVOKABLE int mouseY();
    QWindow *window;
    QQmlApplicationEngine *engine;

private:
    QScreen *screen = QApplication::screens().at(0);
    Xlibutil util;

};

#endif // CONTEXT_H
