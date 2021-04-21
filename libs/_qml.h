#ifndef _QML_H
#define _QML_H
#include <QtCore>
#include <QQmlContext>

inline QQmlContext* rootContext;

static void addClass(const QString name, QObject *obj){
    rootContext->setContextProperty(name, obj);
    qDebug() << "MAIN: Class added " << name;
}


#endif // _QML_H

