#include "backgroundconnect.h"


void BackgroundConnect::BgConnect(QString bg)
{
    QMetaObject::invokeMethod(this->main, "wallpaperRefresh",
        Q_ARG(QVariant, bg)
    );
}
