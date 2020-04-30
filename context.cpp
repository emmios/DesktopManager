#include "context.h"


QString Context::blurEffect(QVariant obj, int screeshot)
{
    Window desktop = -1;

    if (screeshot == 1)
    {
        unsigned long items;
        Window *list = this->xwindows(&items);
        for (int i = 0; i < items; i++)
        {
            QString type = this->xwindowType(list[i]);
            if (type == "_NET_WM_WINDOW_TYPE_DESKTOP")
            {
                desktop = list[i];
                break;
            }
        }
    }
    else
    {
        desktop = 0;
    }

    if (desktop != -1)
    {
        QPixmap map;
        QScreen *screen = QGuiApplication::primaryScreen();
        if (!obj.isNull())
        {
            QObject *_obj = obj.value<QObject *>();
            if (_obj)
            {
                QWindow *win = qobject_cast<QWindow *>(_obj);
                map = screen->grabWindow(desktop, win->x(), win->y(), win->width(), win->height());
            }
        }
        if (!map.isNull())
        {
            QBuffer buffer;
            buffer.open(QIODevice::ReadWrite);
            map.save(&buffer, "jpg");
            const QByteArray bytes = buffer.buffer();
            buffer.close();
            QString base64("data:image/jpg;base64,");
            base64.append(QString::fromLatin1(bytes.toBase64().data()));
            return base64;
        }
    }
    return "";
}

void Context::windowMove(QVariant obj, int x, int y, int w, int h)
{
    if (!obj.isNull())
    {
        QObject *_obj = obj.value<QObject *>();
        if (_obj)
        {
            QWindow *win = qobject_cast<QWindow *>(_obj);
            this->xwindowMove(win->winId(), x, y, w, h);
            this->openboxChange(win->winId(), ALL_DESKTOPS);
            this->xchange(win->winId(), "_NET_WM_WINDOW_TYPE_DESKTOP");
        }
    }
}

QString Context::getImgBackground()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    path = settings.value("background").toString();
    if (path.isEmpty()) path = "file:///usr/share/backgrounds/default.jpg";
    return path;
}

void Context::copy(QString from,QString to)
{
    QFile file(QUrl(from).toLocalFile());
    QString args;

    for (int i =0; ; i++)
    {
        if (i > 0)
        {
            args = "(" + QString::number(i) + ") ";
        } else
        {
            args = "";
        }

        QString fname = to + args + file.fileName().split('/').last();
        QFile f(fname);

        if (!f.exists()) {
            file.copy(fname);
            break;
        }
    }
}

int Context::mouseX()
{
    QPoint Mouse = QCursor::pos(this->screen);
    return Mouse.x();
}

int Context::mouseY()
{
    QPoint Mouse = QCursor::pos(this->screen);
    return Mouse.y();
}

QStringList Context::backgrouds(QString path)
{
    QDir dir(path);
    QStringList lista;

    for (QFileInfo info : dir.entryInfoList(QDir::Files | QDir::NoDot | QDir::NoDotAndDotDot))
    {
        QString name = info.fileName().toLower();
        if (name.contains(".jpg") || name.contains(".png") || name.contains(".jpeg") || name.contains(".mp4"))
        {
            lista << "file://" + info.absoluteFilePath();
        }
    }

    return lista;
}

void Context::backgroundChange(QString bg)
{
//    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "backgroundChange");
//    msg << "ok";
//    QDBusConnection::sessionBus().send(msg);

    QDBusInterface iface("emmi.interface.background", "/", "emmi.interface.background", QDBusConnection::sessionBus());
    if (iface.isValid())
    {
        iface.call("BgConnect", bg);
    }

    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    settings.setValue("background", bg);
}

void Context::allDesktop()
{
//    util.openboxChange(window->winId(), ALL_DESKTOPS);
//    util.xchange(window->winId(), "_NET_WM_WINDOW_TYPE_DESKTOP");
    QObject *obj = this->engine->rootObjects().first();
    QWindow *window = qobject_cast<QWindow *>(obj);

    util.openboxChange(window->winId(), ALL_DESKTOPS);
    util.xchange(window->winId(), "_NET_WM_WINDOW_TYPE_DESKTOP");
}

void Context::terminal()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    path = settings.value("terminal").toString();
    if (path.isEmpty())
    {
        path = "tilix";
        settings.setValue("terminal", "tilix");
    }

    QProcess *process = new QProcess();
    process->start(path);
}

void Context::wallpapers()
{
    QProcess *process = new QProcess();
    process->start("synth-wallpaper");
}

QString Context::color()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/synth/panel/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    QString color = settings.value("color").toString();
    if (color.isEmpty()) color = "#007fff";
    return color;
}
