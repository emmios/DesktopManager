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
#include <QProcess>
#include <QSettings>
#include <QBuffer>

#include "xlibutil.h"


class Context : public QObject, public Xlibutil
{

    Q_OBJECT

public:
    Q_INVOKABLE QString getImgBackground();
    Q_INVOKABLE void copy(QString from,QString to);
    Q_INVOKABLE QStringList backgrouds(QString path);
    Q_INVOKABLE void backgroundChange(QString bg);
    Q_INVOKABLE void allDesktop();
    Q_INVOKABLE void terminal();
    Q_INVOKABLE void wallpapers();
    Q_INVOKABLE int mouseX();
    Q_INVOKABLE int mouseY();
    Q_INVOKABLE QString color();
    Q_INVOKABLE void windowMove(QVariant obj, int x, int y, int w, int h);
    Q_INVOKABLE QString blurEffect(QVariant obj, int screeshot = 1);
    QQmlApplicationEngine *engine;

private:
    QScreen *screen = QApplication::screens().at(0);
    Xlibutil util;

};

#endif // CONTEXT_H
